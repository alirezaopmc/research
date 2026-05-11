from __future__ import annotations

from pathlib import Path

from fastapi.testclient import TestClient

from research.api.main import create_app
from research.domain.paper_reading import (
    PaperMetadataState,
    paper_metadata_from_frontmatter,
)
from research.services.paper_reading.sqlite_store import PaperReadingStore


def test_legacy_status_maps_to_unread_defaults() -> None:
    state = paper_metadata_from_frontmatter({"status": "to-read"})
    assert state.paper_abstract == "UNREAD"
    assert state.paper_content == "UNREAD"
    assert state.paper_reproduced == "NO"


def test_reading_status_normalized_lowercase() -> None:
    state = paper_metadata_from_frontmatter({"reading_status": "reading"})
    assert state.paper_abstract == "READ"
    assert state.paper_content == "READING"


def test_legacy_booleans_map() -> None:
    assert paper_metadata_from_frontmatter({"read_abstract": True}).paper_abstract == "READ"
    s = paper_metadata_from_frontmatter({"read_all": True})
    assert s.paper_abstract == "READ"
    assert s.paper_content == "READ"
    assert s.paper_reproduced == "NO"
    s2 = paper_metadata_from_frontmatter({"reproduced": True})
    assert s2.paper_reproduced == "DONE"
    assert s2.paper_content == "READ"


def test_paper_store_syncs_from_disk_legacy(tmp_path: Path) -> None:
    docs = tmp_path / "docs"
    (docs / "papers").mkdir(parents=True)
    (docs / "papers" / "x.md").write_text(
        "---\ntitle: Z\nreading_status: REPRODUCING\n---\nh\n",
        encoding="utf-8",
    )
    db = tmp_path / "state.sqlite"
    store = PaperReadingStore(db)
    store.sync_from_disk(docs)
    row = store.get_row("papers/x.md")
    assert row is not None
    assert row.paper_abstract == "READ"
    assert row.paper_content == "READ"
    assert row.paper_reproduced == "WORKING"


def test_paper_store_favorites_ordered_by_title(tmp_path: Path) -> None:
    docs = tmp_path / "docs"
    (docs / "papers").mkdir(parents=True)
    (docs / "papers" / "a.md").write_text(
        "---\ntitle: Zeta\npaper_favorite: true\n---\nx\n",
        encoding="utf-8",
    )
    (docs / "papers" / "b.md").write_text(
        "---\ntitle: Alpha\npaper_favorite: true\n---\ny\n",
        encoding="utf-8",
    )
    store = PaperReadingStore(tmp_path / "state.sqlite")
    store.sync_from_disk(docs)
    favs = store.list_favorite_entries()
    assert [f.path for f in favs] == ["papers/b.md", "papers/a.md"]


def test_api_papers_and_note_mirror(tmp_path: Path) -> None:
    docs = tmp_path / "docs"
    (docs / "papers").mkdir(parents=True)
    (docs / "papers" / "demo.md").write_text(
        "---\ntitle: D\nreading_status: READ\n---\nx\n",
        encoding="utf-8",
    )
    app = create_app(
        docs_dir_override=docs,
        search_db_override=tmp_path / "search.sqlite",
        state_db_override=tmp_path / "state.sqlite",
    )
    with TestClient(app) as client:
        lst = client.get("/api/papers/")
        assert lst.status_code == 200
        rows = lst.json()
        hit = next(r for r in rows if r["path"] == "papers/demo.md")
        assert hit["paper_abstract"] == "READ"
        assert hit["paper_content"] == "READ"
        assert hit["paper_reproduced"] == "NO"
        n = client.get("/api/notes/papers/demo.md")
        assert n.status_code == 200
        body = n.json()
        assert body["paper_reading"]["path"] == "papers/demo.md"
        assert body["paper_reading"]["paper_content"] == "READ"


def test_api_patch_paper_metadata(tmp_path: Path) -> None:
    docs = tmp_path / "docs"
    (docs / "papers").mkdir(parents=True)
    (docs / "papers" / "p.md").write_text(
        "---\ntitle: P\npaper_abstract: UNREAD\n---\n",
        encoding="utf-8",
    )
    app = create_app(
        docs_dir_override=docs,
        search_db_override=tmp_path / "search.sqlite",
        state_db_override=tmp_path / "state.sqlite",
    )
    with TestClient(app) as client:
        r = client.patch(
            "/api/papers/papers/p.md",
            json=PaperMetadataState(
                paper_abstract="READ",
                paper_content="READING",
                paper_reproduced="NO",
                paper_favorite=True,
            ).model_dump(),
        )
        assert r.status_code == 200
        j = r.json()
        assert j["paper_abstract"] == "READ"
        assert j["paper_content"] == "READING"
        assert j["paper_reproduced"] == "NO"
        assert j["paper_favorite"] is True


def test_api_patch_coerces_invariants(tmp_path: Path) -> None:
    docs = tmp_path / "docs"
    (docs / "papers").mkdir(parents=True)
    (docs / "papers" / "q.md").write_text(
        "---\ntitle: Q\npaper_abstract: READ\npaper_content: READ\n---\n",
        encoding="utf-8",
    )
    app = create_app(
        docs_dir_override=docs,
        search_db_override=tmp_path / "search.sqlite",
        state_db_override=tmp_path / "state.sqlite",
    )
    with TestClient(app) as client:
        r = client.patch(
            "/api/papers/papers/q.md",
            json={
                "paper_abstract": "UNREAD",
                "paper_content": "READING",
                "paper_reproduced": "DONE",
                "paper_favorite": False,
            },
        )
        assert r.status_code == 200
        j = r.json()
        assert j["paper_abstract"] == "UNREAD"
        assert j["paper_content"] == "UNREAD"
        assert j["paper_reproduced"] == "NO"
