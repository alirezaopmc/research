from __future__ import annotations

import re
from collections.abc import Iterator
from pathlib import Path
from urllib.parse import quote, unquote

import yaml
from markdown_it import MarkdownIt

from research.domain.note import NoteDetail, TreeNode

WIKILINK_RE = re.compile(r"\[\[([^\]|]+)(?:\|([^\]]+))?\]\]")


def split_frontmatter(raw: str) -> tuple[dict, str]:
    if not raw.startswith("---"):
        return {}, raw
    lines = raw.splitlines()
    end: int | None = None
    for i in range(1, len(lines)):
        if lines[i].strip() == "---":
            end = i
            break
    if end is None:
        return {}, raw
    yaml_block = "\n".join(lines[1:end])
    try:
        meta = yaml.safe_load(yaml_block) or {}
        if not isinstance(meta, dict):
            meta = {}
    except Exception:
        meta = {}
    body = "\n".join(lines[end + 1 :]).lstrip("\n")
    return meta, body


def _md_renderer() -> MarkdownIt:
    return MarkdownIt("commonmark", {"html": False}).enable(["table", "strikethrough"])


def extract_wikilinks(text: str) -> list[str]:
    return [m.group(1).strip() for m in WIKILINK_RE.finditer(text)]


def list_markdown_paths(docs: Path) -> list[str]:
    if not docs.is_dir():
        return []
    out: list[str] = []
    for p in sorted(docs.rglob("*.md")):
        rel = p.relative_to(docs).as_posix()
        out.append(rel)
    return out


def build_path_index(docs: Path) -> tuple[set[str], dict[str, str]]:
    """Exact paths + map from stem (no extension, posix) -> path."""
    paths = set(list_markdown_paths(docs))
    by_stem: dict[str, str] = {}
    for rel in paths:
        stem = rel[:-3] if rel.endswith(".md") else rel
        by_stem[stem.casefold()] = rel
        by_stem[Path(stem).name.casefold()] = rel
    return paths, by_stem


def resolve_wikilink(
    target: str,
    docs: Path,
    paths: set[str],
    by_stem: dict[str, str],
) -> str | None:
    t = target.strip().strip("./")
    if not t:
        return None
    candidates: list[str] = []
    if t.endswith(".md"):
        candidates.append(t)
    else:
        candidates.append(f"{t}.md")
        candidates.append(t)
    for c in candidates:
        if c in paths:
            return c
        # normalize slashes
        pc = c.replace("\\", "/")
        if pc in paths:
            return pc
    key = t.casefold()
    if key in by_stem:
        return by_stem[key]
    stem_key = Path(t).name.casefold()
    if stem_key in by_stem:
        return by_stem[stem_key]
    stem_no_md = t[:-3].casefold() if t.endswith(".md") else t.casefold()
    if stem_no_md in by_stem:
        return by_stem[stem_no_md]
    return None


def expand_wikilinks(
    text: str,
    *,
    docs: Path,
    paths: set[str],
    by_stem: dict[str, str],
    link_prefix: str = "/viewer/note/",
) -> str:
    def repl(m: re.Match[str]) -> str:
        target = m.group(1).strip()
        label = (m.group(2) or m.group(1)).strip()
        resolved = resolve_wikilink(target, docs, paths, by_stem)
        if not resolved:
            return m.group(0)
        href = f"{link_prefix}{quote(resolved, safe='/')}"
        return f"[{label}]({href})"

    return WIKILINK_RE.sub(repl, text)


def render_markdown(body: str) -> str:
    return _md_renderer().render(body)


def normalize_rel(rel: str) -> str:
    return unquote(rel).lstrip("/").replace("\\", "/")


def read_note_raw(docs: Path, rel_path: str) -> tuple[dict, str, str]:
    """Return frontmatter, markdown body, full raw (for wikilink extraction from body only)."""
    rel_norm = normalize_rel(rel_path)
    p = (docs / rel_norm).resolve()
    docs_r = docs.resolve()
    if not str(p).startswith(str(docs_r)) or not p.is_file():
        raise FileNotFoundError(rel_path)
    raw = p.read_text(encoding="utf-8")
    meta, body = split_frontmatter(raw)
    return meta, body, raw


class _Trie:
    __slots__ = ("dirs", "files")

    def __init__(self) -> None:
        self.dirs: dict[str, _Trie] = {}
        self.files: list[tuple[str, str]] = []


def _insert(trie: _Trie, parts: list[str], fullpath: str) -> None:
    if len(parts) == 1:
        trie.files.append((parts[0], fullpath))
        return
    head, *rest = parts
    trie.dirs.setdefault(head, _Trie())
    _insert(trie.dirs[head], rest, fullpath)


def _trie_to_nodes(trie: _Trie) -> list[TreeNode]:
    nodes: list[TreeNode] = []
    for name in sorted(trie.dirs):
        sub = trie.dirs[name]
        nodes.append(TreeNode(name=name, type="dir", children=_trie_to_nodes(sub)))
    for name, path in sorted(trie.files, key=lambda x: x[0].casefold()):
        nodes.append(TreeNode(name=name, type="file", path=path))
    return nodes


def build_tree(docs: Path) -> list[TreeNode]:
    root = _Trie()
    for rel in list_markdown_paths(docs):
        _insert(root, rel.split("/"), rel)
    return _trie_to_nodes(root)


def get_note_detail(docs: Path, rel_path: str) -> NoteDetail:
    rel_norm = normalize_rel(rel_path)
    paths, by_stem = build_path_index(docs)
    meta, body, _raw = read_note_raw(docs, rel_norm)
    body_expanded = expand_wikilinks(body, docs=docs, paths=paths, by_stem=by_stem)
    html = render_markdown(body_expanded)
    bl = backlinks_for(docs, rel_norm, paths, by_stem)
    return NoteDetail(
        path=rel_norm,
        frontmatter=meta,
        markdown=body,
        html=html,
        backlinks=bl,
    )


def iter_note_bodies(docs: Path) -> Iterator[tuple[str, dict, str]]:
    for rel in list_markdown_paths(docs):
        raw = (docs / rel).read_text(encoding="utf-8")
        meta, body = split_frontmatter(raw)
        yield rel, meta, body


def backlinks_for(
    docs: Path,
    target_rel: str,
    paths: set[str],
    by_stem: dict[str, str],
) -> list[str]:
    """Files whose body wikilinks resolve to target_rel."""
    out: list[str] = []
    target_cf = target_rel.casefold()
    for rel, _meta, body in iter_note_bodies(docs):
        if rel.casefold() == target_cf:
            continue
        for w in extract_wikilinks(body):
            resolved = resolve_wikilink(w, docs, paths, by_stem)
            if resolved and resolved.casefold() == target_cf:
                out.append(rel)
                break
    return sorted(out)
