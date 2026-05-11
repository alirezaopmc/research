from __future__ import annotations

from pathlib import Path

import pytest

from research.api.main import create_app
from research.services.notes import (
    build_path_index,
    expand_wikilinks,
    extract_wikilinks,
    get_note_detail,
    resolve_wikilink,
)


@pytest.fixture
def docs_dir(tmp_path: Path) -> Path:
    d = tmp_path / "docs"
    d.mkdir()
    (d / "b.md").write_text("# B\n", encoding="utf-8")
    (d / "a.md").write_text("Link [[b]] and [[b|alias]]\n", encoding="utf-8")
    return d


def test_extract_wikilinks(docs_dir: Path) -> None:
    text = (docs_dir / "a.md").read_text(encoding="utf-8")
    assert extract_wikilinks(text) == ["b", "b"]


def test_resolve_wikilink(docs_dir: Path) -> None:
    paths, by_stem = build_path_index(docs_dir)
    assert resolve_wikilink("b", docs_dir, paths, by_stem) == "b.md"


def test_expand_wikilinks(docs_dir: Path) -> None:
    paths, by_stem = build_path_index(docs_dir)
    raw = (docs_dir / "a.md").read_text(encoding="utf-8")
    out = expand_wikilinks(raw, docs=docs_dir, paths=paths, by_stem=by_stem)
    assert "[alias]" in out
    assert "/viewer/note/b.md" in out


def test_render_markdown_linkifies_bare_https_urls():
    from research.services.notes import render_markdown

    html = render_markdown("- **Paper:** https://arxiv.org/abs/2210\n")
    assert '<a href="https://arxiv.org/abs/2210"' in html


def test_backlinks(docs_dir: Path) -> None:
    note = get_note_detail(docs_dir, "b.md")
    assert "a.md" in note.backlinks


def test_api_notes_tree(docs_dir: Path, tmp_path: Path) -> None:
    from fastapi.testclient import TestClient

    app = create_app(
        docs_dir_override=docs_dir,
        search_db_override=tmp_path / "search.sqlite",
        state_db_override=tmp_path / "state.sqlite",
    )
    with TestClient(app) as client:
        r = client.get("/api/notes/")
    assert r.status_code == 200
    data = r.json()
    assert isinstance(data, list)


def test_api_note_detail(docs_dir: Path, tmp_path: Path) -> None:
    from fastapi.testclient import TestClient

    app = create_app(
        docs_dir_override=docs_dir,
        search_db_override=tmp_path / "search.sqlite",
        state_db_override=tmp_path / "state.sqlite",
    )
    with TestClient(app) as client:
        r = client.get("/api/notes/a.md")
    assert r.status_code == 200
    body = r.json()
    assert body["path"] == "a.md"
    assert "<p>" in body["html"]


def test_api_graph(docs_dir: Path, tmp_path: Path) -> None:
    from fastapi.testclient import TestClient

    app = create_app(
        docs_dir_override=docs_dir,
        search_db_override=tmp_path / "search.sqlite",
        state_db_override=tmp_path / "state.sqlite",
    )
    with TestClient(app) as client:
        r = client.get("/api/graph/")
    assert r.status_code == 200
    edges = r.json()["edges"]
    assert any(e["from_path"] == "a.md" and e["to_path"] == "b.md" for e in edges)


def test_api_search(docs_dir: Path, tmp_path: Path) -> None:
    from fastapi.testclient import TestClient

    app = create_app(
        docs_dir_override=docs_dir,
        search_db_override=tmp_path / "search.sqlite",
        state_db_override=tmp_path / "state.sqlite",
    )
    with TestClient(app) as client:
        r = client.get("/api/search/", params={"q": "alias"})
    assert r.status_code == 200
    assert any(h["path"] == "a.md" for h in r.json())


def test_viewer_search_full_page(docs_dir: Path, tmp_path: Path) -> None:
    from fastapi.testclient import TestClient

    app = create_app(
        docs_dir_override=docs_dir,
        search_db_override=tmp_path / "search.sqlite",
        state_db_override=tmp_path / "state.sqlite",
    )
    with TestClient(app) as client:
        r = client.get("/viewer/search", params={"q": "alias"})
    assert r.status_code == 200
    assert "<!DOCTYPE" in r.text
    assert '<main id="main">' in r.text
    assert "a.md" in r.text


def test_viewer_sidebar_tree_expand_and_title_filter_ui(tmp_path: Path) -> None:
    """Collapsible dirs + browse-tree-root / filter input are present when folders exist."""
    from fastapi.testclient import TestClient

    docs = tmp_path / "docs"
    docs.mkdir()
    (docs / "top.md").write_text("# Top\n", encoding="utf-8")
    nest = docs / "papers"
    nest.mkdir()
    (nest / "one.md").write_text("# One\n", encoding="utf-8")

    app = create_app(
        docs_dir_override=docs,
        search_db_override=tmp_path / "search.sqlite",
        state_db_override=tmp_path / "state.sqlite",
    )
    with TestClient(app) as client:
        r = client.get("/viewer/note/papers/one.md")
    assert r.status_code == 200
    body = r.text
    assert 'id="browse-tree-root"' in body
    assert 'id="tree-filter-input"' in body
    assert 'class="tree-branch"' in body
    assert 'class="tree-branch" open' in body  # current note under papers/


def test_viewer_search_htmx_fragment(docs_dir: Path, tmp_path: Path) -> None:
    from fastapi.testclient import TestClient

    app = create_app(
        docs_dir_override=docs_dir,
        search_db_override=tmp_path / "search.sqlite",
        state_db_override=tmp_path / "state.sqlite",
    )
    with TestClient(app) as client:
        r = client.get(
            "/viewer/search",
            params={"q": "alias"},
            headers={"HX-Request": "true"},
        )
    assert r.status_code == 200
    assert "<!DOCTYPE" not in r.text
    assert "a.md" in r.text


def test_viewer_paper_note_includes_props_pane_markup(tmp_path: Path) -> None:
    from fastapi.testclient import TestClient

    docs = tmp_path / "docs"
    docs.mkdir()
    nest = docs / "papers"
    nest.mkdir()
    (nest / "one.md").write_text(
        "---\ntitle: T\nreading_status: READ\n---\n## Paper link\nhttp://example.com/z\n",
        encoding="utf-8",
    )
    app = create_app(
        docs_dir_override=docs,
        search_db_override=tmp_path / "search.sqlite",
        state_db_override=tmp_path / "state.sqlite",
    )
    with TestClient(app) as client:
        r = client.get("/viewer/note/papers/one.md")
    assert r.status_code == 200
    assert "layout-right-sidebar" in r.text
    assert 'id="paper-abstract"' in r.text


def test_viewer_paper_fragment_htmx_includes_props_pane(tmp_path: Path) -> None:
    from fastapi.testclient import TestClient

    docs = tmp_path / "docs"
    docs.mkdir()
    nest = docs / "papers"
    nest.mkdir()
    (nest / "one.md").write_text(
        "---\ntitle: T\nreading_status: UNREAD\n---\n# Hi\n",
        encoding="utf-8",
    )
    app = create_app(
        docs_dir_override=docs,
        search_db_override=tmp_path / "search.sqlite",
        state_db_override=tmp_path / "state.sqlite",
    )
    with TestClient(app) as client:
        r = client.get(
            "/viewer/note/papers/one.md",
            headers={"HX-Request": "true"},
        )
    assert r.status_code == 200
    assert "layout-right-sidebar" in r.text
