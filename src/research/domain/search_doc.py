from __future__ import annotations

from pydantic import BaseModel


class IndexDocument(BaseModel):
    """Normalized document stored in search backends."""

    path: str
    title: str
    body: str
