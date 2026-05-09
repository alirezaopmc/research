from __future__ import annotations

from pathlib import Path

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_prefix="RESEARCH_", env_file=".env", extra="ignore")

    docs_dir: Path = Path("docs")
    host: str = "127.0.0.1"
    port: int = 8000

    def resolved_docs_dir(self, cwd: Path | None = None) -> Path:
        root = cwd or Path.cwd()
        d = self.docs_dir
        return d if d.is_absolute() else (root / d).resolve()
