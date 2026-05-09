from __future__ import annotations

from typing import Any, Literal

from pydantic import BaseModel, Field


class TreeNode(BaseModel):
    name: str
    type: Literal["file", "dir"]
    path: str | None = None
    children: list[TreeNode] = Field(default_factory=list)


class NoteDetail(BaseModel):
    path: str
    frontmatter: dict[str, Any]
    markdown: str
    html: str
    backlinks: list[str]


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
