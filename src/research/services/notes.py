from __future__ import annotations

import re
from collections.abc import Iterator
from pathlib import Path
from urllib.parse import quote, unquote

import yaml
from markdown_it import MarkdownIt

from research.domain.note import NoteDetail, TreeNode

WIKILINK_RE = re.compile(r"\[\[([^\]|]+)(?:\|([^\]]+))?\]\]")

# Shown elsewhere (search, linking) but omitted from sidebar browse trees.
_SIDEBAR_SKIP_PATHS: frozenset[str] = frozenset({"papers/_template.md"})


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
    # gfm-like enables linkify (bare https://…) so paper URLs in lists render as clickable links.
    return MarkdownIt("gfm-like", {"html": False}).enable(["table", "strikethrough"])


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


def _paper_sidebar_store_maps(
    store: object | None,
) -> tuple[
    dict[str, tuple[str, str]],
    dict[str, str],
    dict[str, tuple[str, str]],
    dict[str, str],
    dict[str, bool],
]:
    """path -> reading dot; titles; reproduction chrome; topic; to-read."""
    if store is None:
        return {}, {}, {}, {}, {}
    rows_fn = getattr(store, "list_rows", None)
    if not callable(rows_fn):
        return {}, {}, {}, {}, {}
    from research.domain.paper_reading import paper_repro_sidebar, paper_sidebar_badge

    badges: dict[str, tuple[str, str]] = {}
    titles: dict[str, str] = {}
    repros: dict[str, tuple[str, str]] = {}
    topics: dict[str, str] = {}
    to_reads: dict[str, bool] = {}
    for row in rows_fn():
        badges[row.path] = paper_sidebar_badge(row)
        repros[row.path] = paper_repro_sidebar(row)
        raw_title = getattr(row, "paper_title", "") or ""
        titles[row.path] = raw_title.strip() if isinstance(raw_title, str) else ""
        topics[row.path] = getattr(row, "paper_topic", "") or ""
        to_reads[row.path] = bool(getattr(row, "paper_to_read", False))
    return badges, titles, repros, topics, to_reads


def _paper_leaf_sidebar(
    path: str | None,
    badges: dict[str, tuple[str, str]],
    titles_from_store: dict[str, str],
    repros_from_store: dict[str, tuple[str, str]],
    topics_from_store: dict[str, str],
    to_reads_from_store: dict[str, bool],
) -> tuple[str | None, str | None, str | None, str | None, str | None, str | None, bool | None]:
    """Papers/**/*.md sidebar chrome; returns reading + repro + filter attrs + label."""
    if (
        path is None
        or not path.startswith("papers/")
        or not path.endswith(".md")
        or path in _SIDEBAR_SKIP_PATHS
    ):
        return None, None, None, None, None, None, None
    bk, bt = badges[path] if path in badges else ("abs_unread", "Abstract")
    rk, rt = repros_from_store[path] if path in repros_from_store else ("none", "Reproduction idle")
    stem = Path(path).stem
    raw_title = titles_from_store.get(path, "")
    sidebar_label = raw_title.strip() if raw_title.strip() else stem
    topic = topics_from_store.get(path)
    to_read = to_reads_from_store.get(path)
    return bk, bt, sidebar_label, rk, rt, topic, to_read


def _vault_leaf_sidebar_label(path: str, paper_slab: str | None, docs: Path) -> str:
    """Display + filter text for a file leaf: paper store title, else YAML title, else filename."""
    if paper_slab is not None:
        return paper_slab
    try:
        meta, _, _ = read_note_raw(docs, path)
        t = meta.get("title")
        if isinstance(t, str) and t.strip():
            return t.strip()
    except (OSError, FileNotFoundError, ValueError):
        pass
    return Path(path).name


def _trie_to_nodes(
    trie: _Trie,
    badges: dict[str, tuple[str, str]],
    titles_from_store: dict[str, str],
    repros_from_store: dict[str, tuple[str, str]],
    topics_from_store: dict[str, str],
    to_reads_from_store: dict[str, bool],
    docs: Path,
) -> list[TreeNode]:
    nodes: list[TreeNode] = []
    for name in sorted(trie.dirs):
        sub = trie.dirs[name]
        nodes.append(
            TreeNode(
                name=name,
                type="dir",
                children=_trie_to_nodes(
                    sub,
                    badges,
                    titles_from_store,
                    repros_from_store,
                    topics_from_store,
                    to_reads_from_store,
                    docs,
                ),
            )
        )
    for name, path in sorted(trie.files, key=lambda x: x[0].casefold()):
        bk, bt, slab, rk, rt, topic, to_read = _paper_leaf_sidebar(
            path,
            badges,
            titles_from_store,
            repros_from_store,
            topics_from_store,
            to_reads_from_store,
        )
        label = _vault_leaf_sidebar_label(path, slab, docs)
        nodes.append(
            TreeNode(
                name=name,
                type="file",
                path=path,
                sidebar_label=label,
                paper_badge_kind=bk,
                paper_badge_tooltip=bt,
                paper_repro_kind=rk,
                paper_repro_tooltip=rt,
                paper_topic=topic,
                paper_to_read=to_read,
            )
        )
    return nodes


def build_tree(docs: Path, paper_reading_store: object | None = None) -> list[TreeNode]:
    badges, titles, repros, topics, to_reads = _paper_sidebar_store_maps(paper_reading_store)
    root = _Trie()
    for rel in list_markdown_paths(docs):
        if rel in _SIDEBAR_SKIP_PATHS:
            continue
        _insert(root, rel.split("/"), rel)
    return _trie_to_nodes(root, badges, titles, repros, topics, to_reads, docs)


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
