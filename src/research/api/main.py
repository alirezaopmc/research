from __future__ import annotations

from contextlib import asynccontextmanager
from pathlib import Path

from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles

from research.api.routers import graph, notes, search, viewer
from research.config import Settings

_PKG = Path(__file__).resolve().parent.parent
_WEB_STATIC = _PKG / "web" / "static"


def create_app(*, docs_dir_override: Path | None = None) -> FastAPI:
    @asynccontextmanager
    async def lifespan(app: FastAPI):
        settings = Settings()
        docs = docs_dir_override or settings.resolved_docs_dir()
        app.state.settings = settings
        app.state.docs_dir = docs.resolve()
        yield

    app = FastAPI(title="research", lifespan=lifespan)
    app.include_router(notes.router, prefix="/api/notes", tags=["notes"])
    app.include_router(graph.router, prefix="/api/graph", tags=["graph"])
    app.include_router(search.router, prefix="/api/search", tags=["search"])
    app.include_router(viewer.router, prefix="/viewer", tags=["viewer"])

    if _WEB_STATIC.is_dir():
        app.mount("/static", StaticFiles(directory=str(_WEB_STATIC)), name="static")

    return app


app = create_app()
