from __future__ import annotations

from pathlib import Path

import pytest

from research.api.main import create_app
from research.services.notes import (
    build_path_index,
    build_tree,
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


def test_build_tree_paper_sidebar_dots_use_store(tmp_path: Path) -> None:
    from research.services.paper_reading.sqlite_store import PaperReadingStore

    docs = tmp_path / "docs"
    (docs / "papers").mkdir(parents=True)
    (docs / "papers" / "a.md").write_text(
        "---\ntitle: Paper display title\npaper_abstract: READ\npaper_content: READING\n"
        "paper_reproduced: 'NO'\n---\n",
        encoding="utf-8",
    )
    (docs / "papers" / "b.md").write_text(
        "---\ntitle: Reproduced paper\npaper_abstract: READ\npaper_content: READ\n"
        "paper_reproduced: 'DONE'\n---\n",
        encoding="utf-8",
    )
    (docs / "home.md").write_text("# Hi\n", encoding="utf-8")
    db = tmp_path / "state.sqlite"
    store = PaperReadingStore(db)
    store.sync_from_disk(docs)

    roots = build_tree(docs, store)

    papers = next(n for n in roots if n.type == "dir" and n.name == "papers")
    a_leaf = next(c for c in papers.children if c.name == "a.md")
    assert a_leaf.sidebar_label == "Paper display title"
    assert a_leaf.paper_badge_kind == "content_reading"
    assert a_leaf.paper_badge_tooltip == "Reading"
    assert a_leaf.paper_repro_kind == "none"
    assert a_leaf.paper_repro_tooltip == "Reproduction idle"
    b_leaf = next(c for c in papers.children if c.name == "b.md")
    assert b_leaf.paper_repro_kind == "done"
    assert "reproduced" in b_leaf.paper_repro_tooltip.lower()

    home = next(n for n in roots if n.type == "file" and n.name == "home.md")
    assert home.paper_badge_kind is None


def test_build_tree_hides_papers_template_stub(tmp_path: Path) -> None:
    docs = tmp_path / "docs"
    (docs / "papers").mkdir(parents=True)
    (docs / "papers" / "_template.md").write_text("# Template\n", encoding="utf-8")
    (docs / "papers" / "shown.md").write_text("# Doc\n", encoding="utf-8")

    papers = next(n for n in build_tree(docs) if n.type == "dir" and n.name == "papers")
    file_names = {c.name for c in papers.children if c.type == "file"}

    assert "_template.md" not in file_names
    assert "shown.md" in file_names


def test_build_tree_paper_topic_dir_shows_label(tmp_path: Path) -> None:
    docs = tmp_path / "docs"
    (docs / "papers" / "llm-techniques").mkdir(parents=True)
    (docs / "papers" / "llm-techniques" / "x.md").write_text("---\ntitle: X\n---\n", encoding="utf-8")
    papers = next(n for n in build_tree(docs) if n.type == "dir" and n.name == "papers")
    topic = next(n for n in papers.children if n.name == "llm-techniques")
    assert topic.sidebar_label == "LLM Techniques"


def test_build_tree_nonpaper_uses_frontmatter_title(tmp_path: Path) -> None:
    docs = tmp_path / "docs"
    docs.mkdir()
    (docs / "note.md").write_text("---\ntitle: Human Readable Title\n---\n# x\n", encoding="utf-8")
    roots = build_tree(docs)
    leaf = next(n for n in roots if n.type == "file")
    assert leaf.name == "note.md"
    assert leaf.sidebar_label == "Human Readable Title"


def test_viewer_browse_tree_fragment_reflects_store(tmp_path: Path) -> None:
    """Sidebar tree fragment updates from paper store (same source as PATCH)."""
    from fastapi.testclient import TestClient

    docs = tmp_path / "docs"
    (docs / "papers").mkdir(parents=True)
    (docs / "papers" / "x.md").write_text(
        "---\n"
        "title: X\n"
        "paper_abstract: READ\n"
        "paper_content: READING\n"
        "paper_reproduced: WORKING\n"
        "---\n"
        "# X\n",
        encoding="utf-8",
    )
    app = create_app(
        docs_dir_override=docs,
        search_db_override=tmp_path / "search.sqlite",
        state_db_override=tmp_path / "state.sqlite",
    )
    with TestClient(app) as client:
        r = client.get("/viewer/fragments/browse-tree", params={"current": "papers/x.md"})
        assert r.status_code == 200
        assert "<!DOCTYPE" not in r.text
        assert '<ul class="tree"' in r.text
        assert "tree-paper-dot--content_reading" in r.text
        assert "tree-repro-btn--working" in r.text

        patch = {
            "paper_abstract": "READ",
            "paper_content": "READ",
            "paper_reproduced": "DONE",
            "paper_favorite": False,
        }
        cr = client.patch("/api/papers/papers/x.md", json=patch)
        assert cr.status_code == 200
        r2 = client.get("/viewer/fragments/browse-tree")
        assert "tree-paper-dot--content_read" in r2.text
        assert "tree-repro-btn--done" in r2.text


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
    assert 'id="paper-prop-confirm-modal"' in body
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
    assert 'id="paper-abstract-toggle"' in r.text


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
