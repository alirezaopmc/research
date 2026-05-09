from __future__ import annotations

from pathlib import Path

from research.config import Settings
from research.services.search.protocol import SearchBackend
from research.services.search.sqlite_fts import SqliteFtsBackend


def create_search_backend(settings: Settings, *, db_path: Path | None = None) -> SearchBackend:
    path = db_path or settings.resolved_search_db()
    if settings.search_backend == "sqlite_fts":
        return SqliteFtsBackend(path)
    msg = f"Unsupported RESEARCH_SEARCH_BACKEND={settings.search_backend!r}"
    raise ValueError(msg)
