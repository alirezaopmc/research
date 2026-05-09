from __future__ import annotations

from pathlib import Path
from typing import Protocol, runtime_checkable

from research.domain.note import SearchHit


@runtime_checkable
class SearchBackend(Protocol):
    def reindex(self, docs_dir: Path) -> None: ...

    def search(self, q: str, *, limit: int = 50) -> list[SearchHit]: ...
