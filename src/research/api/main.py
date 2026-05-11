from __future__ import annotations

from contextlib import asynccontextmanager
from pathlib import Path

from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles

from research.api.routers import graph, notes, papers, search, viewer
from research.config import Settings
from research.services.paper_reading.sqlite_store import PaperReadingStore
from research.services.search import create_search_backend

_PKG = Path(__file__).resolve().parent.parent
_WEB_STATIC = _PKG / "web" / "static"


def create_app(
    *,
    docs_dir_override: Path | None = None,
    search_db_override: Path | None = None,
    state_db_override: Path | None = None,
) -> FastAPI:
    @asynccontextmanager
    async def lifespan(app: FastAPI):
        settings = Settings()
        docs = (docs_dir_override or settings.resolved_docs_dir()).resolve()
        app.state.settings = settings
        app.state.docs_dir = docs
        backend = create_search_backend(settings, db_path=search_db_override)
        backend.reindex(docs)
        app.state.search = backend
        state_path = (state_db_override or settings.resolved_state_db()).resolve()
        pr = PaperReadingStore(state_path)
        pr.sync_from_disk(docs)
        app.state.paper_reading = pr
        yield

    app = FastAPI(title="research", lifespan=lifespan)
    app.include_router(notes.router, prefix="/api/notes", tags=["notes"])
    app.include_router(papers.router, prefix="/api/papers", tags=["papers"])
    app.include_router(graph.router, prefix="/api/graph", tags=["graph"])
    app.include_router(search.router, prefix="/api/search", tags=["search"])
    app.include_router(viewer.router, prefix="/viewer", tags=["viewer"])

    if _WEB_STATIC.is_dir():
        app.mount("/static", StaticFiles(directory=str(_WEB_STATIC)), name="static")

    return app


app = create_app()
