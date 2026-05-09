from __future__ import annotations

from pathlib import Path

from research.domain.note import SearchHit
from research.services.notes import list_markdown_paths


def search_notes(docs: Path, q: str, *, limit: int = 50) -> list[SearchHit]:
    qn = q.strip()
    if not qn:
        return []
    ql = qn.lower()
    hits: list[SearchHit] = []
    for rel in list_markdown_paths(docs):
        text = (docs / rel).read_text(encoding="utf-8")
        idx = text.lower().find(ql)
        if idx == -1:
            continue
        start = max(0, idx - 48)
        end = min(len(text), idx + len(qn) + 48)
        snippet = text[start:end].replace("\n", " ").strip()
        hits.append(SearchHit(path=rel, snippet=snippet))
        if len(hits) >= limit:
            break
    return hits
