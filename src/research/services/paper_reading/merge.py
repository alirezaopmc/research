"""Merge persisted paper-reading rows into HTML/API note payloads."""

from __future__ import annotations

from research.domain.note import NoteDetail
from research.services.paper_reading.sqlite_store import PaperReadingStore


def attach_paper_reading(detail: NoteDetail, store: object | None) -> NoteDetail:
    """Set NoteDetail.paper_reading when the path is tracked under docs/papers/."""
    if not isinstance(store, PaperReadingStore):
        return detail
    row = store.get_row(detail.path)
    if row is None:
        return detail
    return detail.model_copy(update={"paper_reading": row})
