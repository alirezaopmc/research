from __future__ import annotations

from fastapi import APIRouter, Request

from research.domain.note import SearchHit

router = APIRouter()


@router.get("/", response_model=list[SearchHit])
def search(request: Request, q: str = "", limit: int = 50) -> list[SearchHit]:
    return request.app.state.search.search(q, limit=limit)
