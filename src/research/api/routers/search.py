from __future__ import annotations

from fastapi import APIRouter, Request

from research.domain.note import SearchHit
from research.services.search import search_notes

router = APIRouter()


@router.get("/", response_model=list[SearchHit])
def search(request: Request, q: str = "") -> list[SearchHit]:
    return search_notes(request.app.state.docs_dir, q)
