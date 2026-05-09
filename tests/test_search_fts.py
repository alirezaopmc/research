from __future__ import annotations

from pathlib import Path

from research.services.search.sqlite_fts import SqliteFtsBackend


def test_sqlite_fts_finds_stemmed_word(tmp_path: Path) -> None:
    docs = tmp_path / "docs"
    docs.mkdir()
    (docs / "note.md").write_text("# Hello\n\nrunning runners run fast.\n", encoding="utf-8")
    db = tmp_path / "idx.sqlite"
    be = SqliteFtsBackend(db)
    be.reindex(docs)
    hits = be.search("running", limit=10)
    assert len(hits) == 1
    assert hits[0].path == "note.md"


def test_sqlite_fts_empty_query(tmp_path: Path) -> None:
    docs = tmp_path / "docs"
    docs.mkdir()
    (docs / "a.md").write_text("x", encoding="utf-8")
    be = SqliteFtsBackend(tmp_path / "i.sqlite")
    be.reindex(docs)
    assert be.search("   ", limit=10) == []
