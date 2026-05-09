from __future__ import annotations

from fastapi import APIRouter, Request

from research.domain.note import GraphData
from research.services.graph import build_graph

router = APIRouter()


@router.get("/", response_model=GraphData)
def graph(request: Request) -> GraphData:
    return build_graph(request.app.state.docs_dir)
