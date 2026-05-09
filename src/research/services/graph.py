from __future__ import annotations

from pathlib import Path

from research.domain.note import GraphData, GraphEdge
from research.services.notes import (
    build_path_index,
    extract_wikilinks,
    iter_note_bodies,
    list_markdown_paths,
    resolve_wikilink,
)


def build_graph(docs: Path) -> GraphData:
    paths, by_stem = build_path_index(docs)
    nodes = list_markdown_paths(docs)
    edges: list[GraphEdge] = []
    for rel, _meta, body in iter_note_bodies(docs):
        for w in extract_wikilinks(body):
            to_path = resolve_wikilink(w, docs, paths, by_stem)
            if to_path:
                edges.append(GraphEdge(from_path=rel, to_path=to_path, target_raw=w))
    return GraphData(nodes=nodes, edges=edges)
