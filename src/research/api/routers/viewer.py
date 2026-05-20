from __future__ import annotations

from pathlib import Path
from urllib.parse import quote

from fastapi import APIRouter, HTTPException, Request
from fastapi.responses import HTMLResponse
from starlette.templating import Jinja2Templates

import research.domain.paper_reading as pr
from research.services.notes import build_tree, get_note_detail
from research.services.paper_reading.merge import attach_paper_reading

_PKG = Path(__file__).resolve().parent.parent.parent
_TEMPLATES = _PKG / "web" / "templates"
templates = Jinja2Templates(directory=str(_TEMPLATES))
templates.env.filters["quote_path"] = lambda p: quote(p, safe="/")
templates.env.globals["paper_abstract_choices"] = pr.PAPER_ABSTRACT_CHOICES
templates.env.globals["paper_content_choices"] = pr.PAPER_CONTENT_CHOICES
templates.env.globals["paper_reproduced_choices"] = pr.PAPER_REPRODUCED_CHOICES
templates.env.globals["paper_topic_choices"] = pr.PAPER_TOPIC_CHOICES
templates.env.globals["paper_topic_labels"] = pr.PAPER_TOPIC_LABELS

_PAPER_CHOICE_LABEL_ABS: dict[str, str] = {"UNREAD": "Unread", "READ": "Read"}
_PAPER_CHOICE_LABEL_CO: dict[str, str] = {
    "UNREAD": "Unread",
    "READING": "Reading",
    "READ": "Read",
}
_PAPER_CHOICE_LABEL_REP: dict[str, str] = {
    "NO": "No",
    "WORKING": "Working",
    "BLOCKED": "Blocked",
    "DONE": "Done",
}
templates.env.globals["paper_choice_label_abs"] = lambda x: _PAPER_CHOICE_LABEL_ABS.get(x, x)
templates.env.globals["paper_choice_label_co"] = lambda x: _PAPER_CHOICE_LABEL_CO.get(x, x)
templates.env.globals["paper_choice_label_rep"] = lambda x: _PAPER_CHOICE_LABEL_REP.get(x, x)

router = APIRouter()


def _docs_dir(request: Request) -> Path:
    return request.app.state.docs_dir


def _viewer_ctx(request: Request, tree, current_path: str = "", **extra: object) -> dict:
    favs = request.app.state.paper_reading.list_favorite_entries()
    out: dict = {"tree": tree, "current_path": current_path, "favorite_papers": favs}
    out.update(extra)
    return out


@router.get("/", response_class=HTMLResponse, name="viewer_home")
def viewer_home(request: Request) -> HTMLResponse:
    tree = build_tree(
        _docs_dir(request),
        getattr(request.app.state, "paper_reading", None),
    )
    return templates.TemplateResponse(
        request,
        "viewer_home.html",
        _viewer_ctx(request, tree, ""),
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
    tree = build_tree(docs, getattr(request.app.state, "paper_reading", None))
    return templates.TemplateResponse(
        request,
        "viewer_search.html",
        _viewer_ctx(
            request,
            tree,
            "",
            hits=hits,
            q=q,
            initial_search_q=q,
        ),
    )


@router.get("/fragments/favorites", response_class=HTMLResponse)
def viewer_favorites_fragment(request: Request) -> HTMLResponse:
    return templates.TemplateResponse(
        request,
        "_favorites_fragment.html",
        {"favorite_papers": request.app.state.paper_reading.list_favorite_entries()},
    )


@router.get("/fragments/browse-tree", response_class=HTMLResponse)
def viewer_browse_tree_fragment(request: Request, current: str = "") -> HTMLResponse:
    """HTML for `#browse-tree-root`; `current` is vault-relative path for active link."""
    tree = build_tree(
        _docs_dir(request),
        getattr(request.app.state, "paper_reading", None),
    )
    return templates.TemplateResponse(
        request,
        "_browse_tree_fragment.html",
        {"tree": tree, "current_path": current},
    )


@router.get("/note/{path:path}", response_class=HTMLResponse)
def viewer_note(path: str, request: Request) -> HTMLResponse:
    docs = _docs_dir(request)
    try:
        note = get_note_detail(docs, path)
    except FileNotFoundError:
        raise HTTPException(status_code=404, detail="Note not found") from None
    store = getattr(request.app.state, "paper_reading", None)
    note = attach_paper_reading(note, store)
    tree = build_tree(docs, getattr(request.app.state, "paper_reading", None))
    is_htmx = request.headers.get("hx-request", "").lower() == "true"
    name = "viewer_note_fragment.html" if is_htmx else "viewer_note.html"
    ctx = _viewer_ctx(request, tree, note.path, note=note)
    return templates.TemplateResponse(request, name, ctx)
