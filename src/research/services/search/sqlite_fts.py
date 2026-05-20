from __future__ import annotations

import re
import sqlite3
from pathlib import Path

from research.domain.note import SearchHit
from research.services.search.documents import iter_index_documents


def _match_expression(raw: str) -> str | None:
    parts = [p for p in re.split(r"\s+", raw.strip()) if p]
    if not parts:
        return None
    escaped: list[str] = []
    for p in parts:
        escaped.append('"' + p.replace('"', '""') + '"')
    return " AND ".join(escaped)


class SqliteFtsBackend:
    """SQLite FTS5 index (local file, BM25 ranking)."""

    __slots__ = ("_db_path",)

    def __init__(self, db_path: Path) -> None:
        self._db_path = db_path

    def reindex(self, docs_dir: Path) -> None:
        self._db_path.parent.mkdir(parents=True, exist_ok=True)
        conn = sqlite3.connect(self._db_path)
        try:
            conn.execute("DROP TABLE IF EXISTS docs")
            try:
                conn.execute("""
                    CREATE VIRTUAL TABLE docs USING fts5(
                        path UNINDEXED,
                        title,
                        body,
                        tokenize = 'porter unicode61'
                    )
                """)
            except sqlite3.OperationalError:
                conn.execute("DROP TABLE IF EXISTS docs")
                conn.execute("""
                    CREATE VIRTUAL TABLE docs USING fts5(
                        path UNINDEXED,
                        title,
                        body,
                        tokenize = 'porter'
                    )
                """)
            rows = [(d.path, d.title, d.body) for d in iter_index_documents(docs_dir)]
            if rows:
                conn.executemany("INSERT INTO docs(path, title, body) VALUES (?,?,?)", rows)
            conn.commit()
        finally:
            conn.close()

    def search(self, q: str, *, limit: int = 50) -> list[SearchHit]:
        match = _match_expression(q)
        if not match:
            return []

        conn = sqlite3.connect(self._db_path)
        try:
            conn.row_factory = sqlite3.Row
            cur = conn.cursor()
            try:
                cur.execute(
                    """
                    SELECT path, snippet(docs, 2, '', '', ' … ', 24) AS snippet
                    FROM docs
                    WHERE docs MATCH ?
                    ORDER BY bm25(docs) ASC
                    LIMIT ?
                    """,
                    (match, limit),
                )
            except sqlite3.OperationalError:
                cur.execute(
                    """
                    SELECT path, snippet(docs, 2, '', '', ' … ', 24) AS snippet
                    FROM docs
                    WHERE docs MATCH ?
                    ORDER BY bm25(docs) ASC
                    LIMIT ?
                    """,
                    (match, limit),
                )
            return [
                SearchHit(path=row["path"], snippet=(row["snippet"] or "").strip())
                for row in cur.fetchall()
            ]
        finally:
            conn.close()
