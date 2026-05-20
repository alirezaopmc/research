from __future__ import annotations

from fastapi import APIRouter, HTTPException, Request

from research.domain.note import NoteDetail, TreeNode
from research.services.notes import build_tree, get_note_detail
from research.services.paper_reading.merge import attach_paper_reading

router = APIRouter()


@router.get("/", response_model=list[TreeNode])
def tree(request: Request) -> list[TreeNode]:
    return build_tree(
        request.app.state.docs_dir,
        getattr(request.app.state, "paper_reading", None),
    )


@router.get("/{path:path}", response_model=NoteDetail)
def note(path: str, request: Request) -> NoteDetail:
    try:
        detail = get_note_detail(request.app.state.docs_dir, path)
    except FileNotFoundError:
        raise HTTPException(status_code=404, detail="Note not found") from None
    store = getattr(request.app.state, "paper_reading", None)
    return attach_paper_reading(detail, store)
