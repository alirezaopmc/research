"""Search implementations (SQLite FTS today; plug in Meilisearch later via `SearchBackend`)."""

from research.services.search.factory import create_search_backend
from research.services.search.protocol import SearchBackend
from research.services.search.sqlite_fts import SqliteFtsBackend

__all__ = ["SearchBackend", "SqliteFtsBackend", "create_search_backend"]
