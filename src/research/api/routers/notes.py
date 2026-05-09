from __future__ import annotations

from fastapi import APIRouter, HTTPException, Request

from research.domain.note import NoteDetail, TreeNode
from research.services.notes import build_tree, get_note_detail

router = APIRouter()


@router.get("/", response_model=list[TreeNode])
def tree(request: Request) -> list[TreeNode]:
    return build_tree(request.app.state.docs_dir)


@router.get("/{path:path}", response_model=NoteDetail)
def note(path: str, request: Request) -> NoteDetail:
    try:
        return get_note_detail(request.app.state.docs_dir, path)
    except FileNotFoundError:
        raise HTTPException(status_code=404, detail="Note not found") from None
