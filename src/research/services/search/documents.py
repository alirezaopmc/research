from __future__ import annotations

from collections.abc import Iterator
from pathlib import Path

from research.domain.search_doc import IndexDocument
from research.services.notes import list_markdown_paths, split_frontmatter


def _title_from_body(body: str) -> str | None:
    for line in body.splitlines():
        s = line.strip()
        if s.startswith("#"):
            return s.lstrip("#").strip() or None
    return None


def iter_index_documents(docs_dir: Path) -> Iterator[IndexDocument]:
    for rel in list_markdown_paths(docs_dir):
        raw = (docs_dir / rel).read_text(encoding="utf-8")
        meta, body = split_frontmatter(raw)
        title = meta.get("title") if isinstance(meta.get("title"), str) else None
        if not title:
            title = _title_from_body(body)
        if not title:
            title = Path(rel).stem
        yield IndexDocument(path=rel, title=title, body=body)
