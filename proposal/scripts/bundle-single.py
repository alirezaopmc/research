#!/usr/bin/env python3
"""Bundle the proposal Typst entry point into one self-contained .typ file.

Inlines every local `#import` in dependency order and drops the import lines.
YAML under src/content (except local-only signed data) is embedded behind a
`yaml` shim. Asset paths are rewritten to be relative to the output file.

Checked, not silently ignored:
- imports: `#import "<local>.typ": names | *` at column 0 only (no `as`, no packages);
- top-level `#let` names must be unique across the bundle;
- `yaml()` may only be called from src/lib/content.typ (the sole loader).
"""

from __future__ import annotations

import argparse
import os
import re
import sys
from dataclasses import dataclass
from pathlib import Path

PROPOSAL = Path(__file__).resolve().parent.parent
SRC = PROPOSAL / "src"
CONTENT = SRC / "content"
LIB = SRC / "lib"
ASSETS = PROPOSAL / "assets"
CONTENT_LOADER = LIB / "content.typ"
DEFAULT_ENTRY = SRC / "main" / "fa" / "proposal.typ"
DEFAULT_OUT = PROPOSAL / "dist" / "proposal-single.typ"

# Local-only signed data (gitignored) and the cheatsheet's own entry point stay out of the bundle.
SIGNED_YAML_SUFFIX = ".signed.yaml"
EXCLUDED_DOCUMENTS = ("cheatsheet",)
SHIM_NAMES = ("yaml", "_builtin-yaml", "_yaml-sources")

IMPORT_START = re.compile(r'^#import\s+"([^"]+)"\s*:\s*', re.MULTILINE)
IMPORT_ANY = re.compile(r"#import\b")
TOP_LET = re.compile(r"^#let\s+([A-Za-z_][\w-]*)", re.MULTILINE)
TOP_LET_DESTRUCTURE = re.compile(r"^#let\s*\(", re.MULTILINE)
YAML_CALL = re.compile(r"(?<![\w-])yaml\s*\(")
STRING_LITERAL = re.compile(r'"((?:[^"\\\n]|\\.)*)"')


class BundleError(Exception):
    pass


@dataclass(frozen=True)
class Module:
    path: Path
    imports: tuple[Path, ...]
    body: str  # source with every import statement removed


def _import_end(text: str, pos: int) -> int:
    if text[pos : pos + 1] == "(":
        return text.index(")", pos) + 1
    newline = text.find("\n", pos)
    return len(text) if newline == -1 else newline + 1


def parse_module(path: Path) -> Module:
    text = path.read_text(encoding="utf-8")
    imports: list[Path] = []
    pieces: list[str] = []
    cursor = 0
    for match in IMPORT_START.finditer(text):
        spec = match.group(1)
        if spec.startswith("@") or not spec.endswith(".typ"):
            raise BundleError(f"{_rel(path)}: unsupported import '{spec}'")
        target = Path(os.path.normpath(path.parent / spec))
        if not _is_under(target, SRC) or not target.is_file():
            raise BundleError(f"{_rel(path)}: import '{spec}' is not a file under src/")
        pieces.append(text[cursor : match.start()])
        cursor = _import_end(text, match.end())
        imports.append(target)
    pieces.append(text[cursor:])
    if len(IMPORT_ANY.findall(text)) != len(imports):
        raise BundleError(
            f"{_rel(path)}: unsupported #import form (must start a line; use ': names' or ': *')"
        )
    return Module(path=path, imports=tuple(imports), body="".join(pieces))


def collect_modules(entry: Path) -> list[Module]:
    ordered: list[Module] = []
    done: set[Path] = set()

    def visit(path: Path, stack: tuple[Path, ...]) -> None:
        if path in done:
            return
        if path in stack:
            cycle = " -> ".join(_rel(p) for p in (*stack, path))
            raise BundleError(f"import cycle: {cycle}")
        module = parse_module(path)
        for dep in module.imports:
            visit(dep, (*stack, path))
        done.add(path)
        ordered.append(module)

    visit(entry, ())
    return ordered


def top_level_names(module: Module) -> list[str]:
    if TOP_LET_DESTRUCTURE.search(module.body):
        raise BundleError(f"{_rel(module.path)}: top-level destructuring #let is unsupported")
    return TOP_LET.findall(module.body)


def check_yaml_calls(module: Module) -> None:
    if module.path != CONTENT_LOADER and YAML_CALL.search(module.body):
        raise BundleError(
            f"{_rel(module.path)}: yaml() is only bundled for {_rel(CONTENT_LOADER)}"
        )


def rewrite_assets(text: str, module_dir: Path, out_dir: Path) -> str:
    def repl(match: re.Match[str]) -> str:
        literal = match.group(1)
        if not literal.startswith(("./", "../")):
            return match.group(0)
        target = os.path.normpath(module_dir / literal)
        if not _is_under(Path(target), ASSETS) and target != str(ASSETS):
            return match.group(0)
        rewritten = os.path.relpath(target, out_dir).replace(os.sep, "/")
        if literal.endswith("/"):
            rewritten += "/"
        return f'"{rewritten}"'

    return STRING_LITERAL.sub(repl, text)


def yaml_sources() -> dict[str, str]:
    # Keys match the paths content.typ passes to yaml(), which resolve from src/lib/.
    sources: dict[str, str] = {}
    for path in sorted(CONTENT.rglob("*.yaml")):
        if path.name.endswith(SIGNED_YAML_SUFFIX):
            continue
        # content/<locale>/<document>/...
        if path.relative_to(CONTENT).parts[1] in EXCLUDED_DOCUMENTS:
            continue
        key = os.path.relpath(path, LIB).replace(os.sep, "/")
        sources[key] = path.read_text(encoding="utf-8")
    return sources


def yaml_shim(sources: dict[str, str]) -> str:
    entries = "\n".join(
        f"  {_typ_string(key)}: {_typ_string(text)}," for key, text in sources.items()
    )
    return "\n".join(
        [
            "// Bundled YAML: yaml() reads these strings instead of files.",
            "#let _builtin-yaml = yaml",
            "#let _yaml-sources = (",
            entries,
            ")",
            "#let yaml(path) = {",
            '  assert(path in _yaml-sources, message: "yaml not bundled: " + path)',
            "  _builtin-yaml(bytes(_yaml-sources.at(path)))",
            "}",
        ]
    )


def bundle(entry: Path, out: Path) -> None:
    modules = collect_modules(entry)
    owners: dict[str, Path] = {name: Path("<bundle>") for name in SHIM_NAMES}
    chunks: list[str] = []
    for module in modules:
        check_yaml_calls(module)
        for name in top_level_names(module):
            if name in owners:
                raise BundleError(
                    f"duplicate #let '{name}': {_rel(owners[name])} and {_rel(module.path)}"
                )
            owners[name] = module.path
        body = rewrite_assets(module.body, module.path.parent, out.parent)
        chunks.append(f"// ===== {_rel(module.path)} =====\n{body.strip()}\n")

    header = "\n".join(
        [
            "// Single-file proposal. Generated by proposal/scripts/bundle-single.py; do not edit.",
            "// Compile from proposal/: typst compile --root . --font-path assets/fonts dist/proposal-single.typ",
        ]
    )
    result = "\n\n".join([header, yaml_shim(yaml_sources()), *chunks])
    if re.search(r"^#import\b", result, re.MULTILINE):
        raise BundleError("bundle still contains #import")

    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(result, encoding="utf-8")


def _typ_string(value: str) -> str:
    escaped = (
        value.replace("\\", "\\\\")
        .replace('"', '\\"')
        .replace("\n", "\\n")
        .replace("\r", "\\r")
        .replace("\t", "\\t")
    )
    return f'"{escaped}"'


def _is_under(path: Path, root: Path) -> bool:
    return str(path).startswith(str(root) + os.sep)


def _rel(path: Path) -> str:
    return os.path.relpath(path, PROPOSAL).replace(os.sep, "/")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--entry", type=Path, default=DEFAULT_ENTRY)
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT)
    args = parser.parse_args(argv)
    entry = args.entry.resolve()
    out = args.out.resolve()
    try:
        if not _is_under(entry, SRC) or not entry.is_file():
            raise BundleError(f"entry must be a file under src/: {args.entry}")
        bundle(entry, out)
    except BundleError as error:
        print(f"error: {error}", file=sys.stderr)
        return 1
    print(f"Built {out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
