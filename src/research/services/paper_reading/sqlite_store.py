from __future__ import annotations

import sqlite3
from pathlib import Path

from research.domain.paper_reading import (
    PaperFavoriteEntry,
    PaperReadingRow,
    paper_reading_row_from_meta,
)
from research.services.notes import split_frontmatter

_EXPECTED_COLUMNS = frozenset(
    {"path", "paper_abstract", "paper_content", "paper_reproduced", "paper_favorite", "paper_title"}
)


def list_paper_note_paths(docs: Path) -> list[str]:
    """Paths relative to docs (posix), excluding _template.md."""
    papers_dir = docs / "papers"
    if not papers_dir.is_dir():
        return []
    out: list[str] = []
    for p in sorted(papers_dir.glob("*.md")):
        if p.name == "_template.md":
            continue
        out.append(p.relative_to(docs).as_posix())
    return out


class PaperReadingStore:
    """Mirror paper_* frontmatter into SQLite (refresh on sync)."""

    def __init__(self, db_path: Path) -> None:
        self._db_path = db_path

    def init_schema(self) -> None:
        self._db_path.parent.mkdir(parents=True, exist_ok=True)
        with sqlite3.connect(self._db_path) as conn:
            row = conn.execute(
                "SELECT name FROM sqlite_master WHERE type='table' AND name='paper_reading'"
            ).fetchone()
            if row:
                cols = {r[1] for r in conn.execute("PRAGMA table_info(paper_reading)").fetchall()}
                if cols != _EXPECTED_COLUMNS:
                    conn.execute("DROP TABLE paper_reading")

            conn.execute(
                """
                CREATE TABLE IF NOT EXISTS paper_reading (
                  path TEXT PRIMARY KEY NOT NULL,
                  paper_abstract TEXT NOT NULL,
                  paper_content TEXT NOT NULL,
                  paper_reproduced TEXT NOT NULL,
                  paper_favorite INTEGER NOT NULL,
                  paper_title TEXT NOT NULL DEFAULT ''
                )
                """
            )

    def sync_from_disk(self, docs: Path) -> int:
        """Upsert rows from docs/papers/*.md; purge orphaned paper rows."""
        self.init_schema()
        paths_on_disk = set(list_paper_note_paths(docs))
        upserted = 0
        with sqlite3.connect(self._db_path) as conn:
            conn.execute("BEGIN")
            for rel in sorted(paths_on_disk):
                meta, _body = split_frontmatter((docs / rel).read_text(encoding="utf-8"))
                row = paper_reading_row_from_meta(rel, meta)
                conn.execute(
                    """
                    INSERT INTO paper_reading
                      (path, paper_abstract, paper_content, paper_reproduced,
                       paper_favorite, paper_title)
                    VALUES (?, ?, ?, ?, ?, ?)
                    ON CONFLICT(path) DO UPDATE SET
                      paper_abstract = excluded.paper_abstract,
                      paper_content = excluded.paper_content,
                      paper_reproduced = excluded.paper_reproduced,
                      paper_favorite = excluded.paper_favorite,
                      paper_title = excluded.paper_title
                    """,
                    (
                        row.path,
                        row.paper_abstract,
                        row.paper_content,
                        row.paper_reproduced,
                        int(row.paper_favorite),
                        row.paper_title,
                    ),
                )
                upserted += 1
            placeholders = ",".join("?" * len(paths_on_disk))
            if paths_on_disk:
                conn.execute(
                    f"""
                    DELETE FROM paper_reading
                    WHERE path LIKE 'papers/%' AND path NOT IN ({placeholders})
                    """,
                    tuple(sorted(paths_on_disk)),
                )
            else:
                conn.execute("DELETE FROM paper_reading WHERE path LIKE 'papers/%'")
            conn.execute("COMMIT")
        return upserted

    def get_row(self, rel_path: str) -> PaperReadingRow | None:
        rel_norm = rel_path.replace("\\", "/").lstrip("/")
        if not rel_norm.startswith("papers/"):
            return None
        self.init_schema()
        with sqlite3.connect(self._db_path) as conn:
            conn.row_factory = sqlite3.Row
            row = conn.execute(
                "SELECT path, paper_abstract, paper_content, paper_reproduced, "
                "paper_favorite, paper_title FROM paper_reading WHERE path = ?",
                (rel_norm,),
            ).fetchone()
            if row is None:
                return None
            return PaperReadingRow(
                path=row["path"],
                paper_abstract=row["paper_abstract"],
                paper_content=row["paper_content"],
                paper_reproduced=row["paper_reproduced"],
                paper_favorite=bool(row["paper_favorite"]),
                paper_title=row["paper_title"] or "",
            )

    def list_rows(self) -> list[PaperReadingRow]:
        self.init_schema()
        with sqlite3.connect(self._db_path) as conn:
            conn.row_factory = sqlite3.Row
            cur = conn.execute(
                "SELECT path, paper_abstract, paper_content, paper_reproduced, "
                "paper_favorite, paper_title FROM paper_reading ORDER BY path"
            )
            rows = cur.fetchall()
        return [
            PaperReadingRow(
                path=row["path"],
                paper_abstract=row["paper_abstract"],
                paper_content=row["paper_content"],
                paper_reproduced=row["paper_reproduced"],
                paper_favorite=bool(row["paper_favorite"]),
                paper_title=row["paper_title"] or "",
            )
            for row in rows
        ]

    def list_favorite_entries(self) -> list[PaperFavoriteEntry]:
        self.init_schema()
        with sqlite3.connect(self._db_path) as conn:
            conn.row_factory = sqlite3.Row
            cur = conn.execute(
                """
                SELECT path, paper_title FROM paper_reading
                WHERE paper_favorite = 1
                ORDER BY paper_title COLLATE NOCASE
                """
            )
            return [
                PaperFavoriteEntry(path=row["path"], title=row["paper_title"] or row["path"])
                for row in cur.fetchall()
            ]
