from __future__ import annotations

from pathlib import Path
from typing import Literal

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_prefix="RESEARCH_", env_file=".env", extra="ignore")

    docs_dir: Path = Path("docs")
    search_db: Path = Path(".research/search.sqlite")
    state_db: Path = Path(".research/state.sqlite")
    search_backend: Literal["sqlite_fts"] = "sqlite_fts"
    host: str = "127.0.0.1"
    port: int = 8000

    def resolved_docs_dir(self, cwd: Path | None = None) -> Path:
        root = cwd or Path.cwd()
        d = self.docs_dir
        return d if d.is_absolute() else (root / d).resolve()

    def resolved_search_db(self, cwd: Path | None = None) -> Path:
        root = cwd or Path.cwd()
        p = self.search_db
        return p if p.is_absolute() else (root / p).resolve()

    def resolved_state_db(self, cwd: Path | None = None) -> Path:
        root = cwd or Path.cwd()
        p = self.state_db
        return p if p.is_absolute() else (root / p).resolve()
