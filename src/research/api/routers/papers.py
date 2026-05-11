from __future__ import annotations

from pathlib import Path

from fastapi import APIRouter, HTTPException, Request

from research.domain.paper_reading import PaperMetadataState, PaperReadingRow
from research.services.paper_reading.io import write_paper_metadata

router = APIRouter()


@router.get("/", response_model=list[PaperReadingRow])
def paper_index(request: Request) -> list[PaperReadingRow]:
    return request.app.state.paper_reading.list_rows()


@router.patch("/{path:path}", response_model=PaperReadingRow)
def patch_paper(request: Request, path: str, body: PaperMetadataState) -> PaperReadingRow:
    docs: Path = request.app.state.docs_dir
    try:
        rel = write_paper_metadata(docs, path, body)
    except FileNotFoundError as e:
        raise HTTPException(status_code=404, detail=str(e)) from e
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e)) from e

    store = request.app.state.paper_reading
    store.sync_from_disk(docs)
    row = store.get_row(rel)
    if row is None:
        msg = "paper row missing after sync"
        raise HTTPException(status_code=500, detail=msg)
    return row
