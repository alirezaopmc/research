from __future__ import annotations

from typing import Any, Literal

from pydantic import BaseModel, Field

from research.domain.paper_reading import PaperReadingRow


class TreeNode(BaseModel):
    name: str
    type: Literal["file", "dir"]
    path: str | None = None
    children: list[TreeNode] = Field(default_factory=list)
    # Display label for sidebar link (vault: basename.md; papers: title without .md when known).
    sidebar_label: str | None = None
    # Reading progress dot chrome (outside link).
    paper_badge_kind: str | None = None
    paper_badge_tooltip: str | None = None
    paper_repro_kind: str | None = None
    paper_repro_tooltip: str | None = None
    paper_topic: str | None = None
    paper_to_read: bool | None = None


class NoteDetail(BaseModel):
    path: str
    frontmatter: dict[str, Any]
    markdown: str
    html: str
    backlinks: list[str]
    paper_reading: PaperReadingRow | None = None


class GraphEdge(BaseModel):
    from_path: str
    to_path: str
    target_raw: str


class GraphData(BaseModel):
    nodes: list[str]
    edges: list[GraphEdge]


class SearchHit(BaseModel):
    path: str
    snippet: str
