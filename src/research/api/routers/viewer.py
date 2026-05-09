from __future__ import annotations

from pathlib import Path
from urllib.parse import quote

from fastapi import APIRouter, HTTPException, Request
from fastapi.responses import HTMLResponse
from starlette.templating import Jinja2Templates

from research.services.notes import build_tree, get_note_detail

_PKG = Path(__file__).resolve().parent.parent.parent
_TEMPLATES = _PKG / "web" / "templates"
templates = Jinja2Templates(directory=str(_TEMPLATES))
templates.env.filters["quote_path"] = lambda p: quote(p, safe="/")

router = APIRouter()


def _docs_dir(request: Request) -> Path:
    return request.app.state.docs_dir


@router.get("/", response_class=HTMLResponse, name="viewer_home")
def viewer_home(request: Request) -> HTMLResponse:
    tree = build_tree(_docs_dir(request))
    return templates.TemplateResponse(
        request,
        "viewer_home.html",
        {"tree": tree, "note": None, "current_path": ""},
    )


@router.get("/search", response_class=HTMLResponse)
def viewer_search(request: Request, q: str = "") -> HTMLResponse:
    hits = request.app.state.search.search(q, limit=30)
    is_htmx = request.headers.get("hx-request", "").lower() == "true"
    if is_htmx:
        return templates.TemplateResponse(
            request,
            "_search_results.html",
            {"hits": hits, "q": q},
        )
    docs = _docs_dir(request)
    tree = build_tree(docs)
    return templates.TemplateResponse(
        request,
        "viewer_search.html",
        {
            "tree": tree,
            "current_path": "",
            "hits": hits,
            "q": q,
            "initial_search_q": q,
        },
    )


@router.get("/note/{path:path}", response_class=HTMLResponse)
def viewer_note(path: str, request: Request) -> HTMLResponse:
    docs = _docs_dir(request)
    try:
        note = get_note_detail(docs, path)
    except FileNotFoundError:
        raise HTTPException(status_code=404, detail="Note not found") from None
    tree = build_tree(docs)
    is_htmx = request.headers.get("hx-request", "").lower() == "true"
    name = "viewer_note_fragment.html" if is_htmx else "viewer_note.html"
    return templates.TemplateResponse(
        request,
        name,
        {"tree": tree, "note": note, "current_path": note.path},
    )
