from __future__ import annotations

from typing import Any, Literal

from pydantic import BaseModel, model_validator

type PaperAbstractStatus = Literal["UNREAD", "READ"]
type PaperContentStatus = Literal["UNREAD", "READING", "READ"]
type PaperReproducedStatus = Literal["NO", "WORKING", "BLOCKED", "DONE"]
type PaperTopicSlug = Literal["llm-techniques"]

PAPER_ABSTRACT_CHOICES: tuple[PaperAbstractStatus, ...] = ("UNREAD", "READ")
PAPER_CONTENT_CHOICES: tuple[PaperContentStatus, ...] = ("UNREAD", "READING", "READ")
PAPER_REPRODUCED_CHOICES: tuple[PaperReproducedStatus, ...] = (
    "NO",
    "WORKING",
    "BLOCKED",
    "DONE",
)
PAPER_TOPIC_CHOICES: tuple[PaperTopicSlug, ...] = ("llm-techniques",)
PAPER_TOPIC_LABELS: dict[PaperTopicSlug, str] = {
    "llm-techniques": "LLM Techniques",
}
_PAPER_TOPIC_SLUGS: frozenset[str] = frozenset(PAPER_TOPIC_CHOICES)

# Legacy single-field enum (maps to quartet)
type ReadingStatus = Literal[
    "UNREAD",
    "READ_ABSTRACT",
    "READING",
    "READ",
    "REPRODUCING",
    "REPRODUCED",
]

_READING_VALUES: frozenset[str] = frozenset(
    {"UNREAD", "READ_ABSTRACT", "READING", "READ", "REPRODUCING", "REPRODUCED"}
)


def _truthy_legacy(v: Any) -> bool:
    if isinstance(v, bool):
        return v
    if v in (None, "", 0, "0", "false", "False"):
        return False
    if isinstance(v, (int, float)) and not isinstance(v, bool):
        return v != 0
    if isinstance(v, str):
        return v.strip().lower() in {"1", "true", "yes", "y"}
    return bool(v)


def _norm_upper(v: Any) -> str | None:
    if v is None:
        return None
    if isinstance(v, str):
        return v.strip().upper().replace("-", "_")
    return None


def _parse_abstract(meta: dict[str, Any]) -> PaperAbstractStatus | None:
    s = _norm_upper(meta.get("paper_abstract"))
    if s in {"UNREAD", "READ"}:
        return s  # type: ignore[return-value]
    return None


def _parse_content(meta: dict[str, Any]) -> PaperContentStatus | None:
    s = _norm_upper(meta.get("paper_content"))
    if s in {"UNREAD", "READING", "READ"}:
        return s  # type: ignore[return-value]
    return None


def _parse_topic(meta: dict[str, Any]) -> PaperTopicSlug | None:
    raw = meta.get("topic")
    if raw is None:
        raw = meta.get("Topic")
    if not isinstance(raw, str):
        return None
    slug = raw.strip().lower().replace("_", "-").replace(" ", "-")
    if slug in _PAPER_TOPIC_SLUGS:
        return slug  # type: ignore[return-value]
    return None


def topic_slug_from_paper_path(path: str) -> PaperTopicSlug | None:
    """Infer topic from docs/papers/<topic>/<file>.md when frontmatter omits it."""
    parts = path.replace("\\", "/").split("/")
    if len(parts) >= 3 and parts[0] == "papers" and parts[1] in _PAPER_TOPIC_SLUGS:
        return parts[1]  # type: ignore[return-value]
    return None


def _parse_to_read(meta: dict[str, Any]) -> bool | None:
    if "paper_to_read" in meta:
        return _truthy_legacy(meta.get("paper_to_read"))
    if meta.get("status") == "to-read":
        return True
    rs = _legacy_reading_status(meta) or _legacy_status_line(meta)
    if rs == "UNREAD":
        return True
    if rs is not None:
        return False
    return None


def _parse_reproduced(meta: dict[str, Any]) -> PaperReproducedStatus | None:
    s = _norm_upper(meta.get("paper_reproduced"))
    if s in {"NO", "WORKING", "BLOCKED", "DONE"}:
        return s  # type: ignore[return-value]
    return None


def _legacy_reading_status(meta: dict[str, Any]) -> ReadingStatus | None:
    rs = meta.get("reading_status")
    if not isinstance(rs, str):
        return None
    s = rs.strip().upper().replace("-", "_")
    if s in {"TO_READ"}:
        return "UNREAD"
    if s in _READING_VALUES:
        return s  # type: ignore[return-value]
    return None


def _legacy_status_line(meta: dict[str, Any]) -> ReadingStatus | None:
    legacy = meta.get("status")
    if legacy == "to-read":
        return "UNREAD"
    if legacy == "reading":
        return "READING"
    if legacy == "read":
        return "READ"
    if isinstance(legacy, str):
        return _legacy_reading_status({"reading_status": legacy})
    return None


def _from_legacy_reading(
    rs: ReadingStatus,
) -> tuple[PaperAbstractStatus, PaperContentStatus, PaperReproducedStatus]:
    if rs == "UNREAD":
        return "UNREAD", "UNREAD", "NO"
    if rs == "READ_ABSTRACT":
        return "READ", "UNREAD", "NO"
    if rs == "READING":
        return "READ", "READING", "NO"
    if rs == "READ":
        return "READ", "READ", "NO"
    if rs == "REPRODUCING":
        return "READ", "READ", "WORKING"
    if rs == "REPRODUCED":
        return "READ", "READ", "DONE"
    return "UNREAD", "UNREAD", "NO"


class PaperMetadataState(BaseModel):
    """Coherent paper workflow fields (frontmatter + API)."""

    paper_abstract: PaperAbstractStatus = "UNREAD"
    paper_content: PaperContentStatus = "UNREAD"
    paper_reproduced: PaperReproducedStatus = "NO"
    paper_favorite: bool = False
    paper_topic: PaperTopicSlug = "llm-techniques"
    paper_to_read: bool = False

    model_config = {"frozen": True}

    @model_validator(mode="after")
    def _coerce(self) -> PaperMetadataState:
        """Enforce dependency rules without re-invoking validators (avoid recursion)."""
        ab = self.paper_abstract
        co = self.paper_content
        re = self.paper_reproduced
        if ab == "UNREAD":
            if co == "UNREAD" and re == "NO":
                return self
            return PaperMetadataState.model_construct(
                paper_abstract="UNREAD",
                paper_content="UNREAD",
                paper_reproduced="NO",
                paper_favorite=self.paper_favorite,
                paper_topic=self.paper_topic,
                paper_to_read=self.paper_to_read,
            )
        if co == "UNREAD":
            if re == "NO":
                return self
            return PaperMetadataState.model_construct(
                paper_abstract=ab,
                paper_content="UNREAD",
                paper_reproduced="NO",
                paper_favorite=self.paper_favorite,
                paper_topic=self.paper_topic,
                paper_to_read=self.paper_to_read,
            )
        return self


class PaperReadingRow(BaseModel):
    path: str
    paper_abstract: PaperAbstractStatus
    paper_content: PaperContentStatus
    paper_reproduced: PaperReproducedStatus
    paper_favorite: bool
    paper_topic: PaperTopicSlug
    paper_to_read: bool
    paper_title: str = ""

    model_config = {"frozen": True}


def paper_sidebar_badge(row: PaperReadingRow) -> tuple[str, str]:
    """Browsing UX: compact status dot — (css_suffix, tooltip one word).

    Covers abstract unread, content queue/reading/read (abstract READ implied for the last three).
    """
    if row.paper_abstract == "UNREAD":
        return "abs_unread", "Abstract"
    if row.paper_content == "UNREAD":
        return "content_unread", "Queued"
    if row.paper_content == "READING":
        return "content_reading", "Reading"
    return "content_read", "Read"


def paper_repro_sidebar(row: PaperReadingRow) -> tuple[str, str]:
    """Sidebar repro tool — (css modifier, descriptive tooltip phrase)."""
    key = row.paper_reproduced
    if key == "NO":
        return "none", "Reproduction idle"
    if key == "WORKING":
        return "working", "Reproducing"
    if key == "BLOCKED":
        return "blocked", "Reproduction blocked"
    return "done", "Results reproduced"


class PaperFavoriteEntry(BaseModel):
    path: str
    title: str

    model_config = {"frozen": True}


def paper_metadata_from_frontmatter(
    meta: dict[str, Any],
    *,
    path: str | None = None,
) -> PaperMetadataState:
    """Build metadata from YAML; maps legacy reading_status / booleans."""
    pa = _parse_abstract(meta)
    pc = _parse_content(meta)
    pr = _parse_reproduced(meta)
    fav = _truthy_legacy(meta.get("paper_favorite"))
    topic = _parse_topic(meta) or (topic_slug_from_paper_path(path) if path else None)
    to_read = _parse_to_read(meta)

    if pa is not None and pc is not None and pr is not None:
        return PaperMetadataState(
            paper_abstract=pa,
            paper_content=pc,
            paper_reproduced=pr,
            paper_favorite=fav,
            paper_topic=topic or "llm-techniques",
            paper_to_read=to_read if to_read is not None else False,
        )

    rs = _legacy_reading_status(meta) or _legacy_status_line(meta)
    if rs is None:
        if _truthy_legacy(meta.get("reproduced")):
            rs = "REPRODUCED"
        elif _truthy_legacy(meta.get("read_all")):
            rs = "READ"
        elif _truthy_legacy(meta.get("read_abstract")):
            rs = "READ_ABSTRACT"
        else:
            rs = "UNREAD"

    a, c, r = _from_legacy_reading(rs)
    resolved_to_read = to_read if to_read is not None else rs == "UNREAD"
    return PaperMetadataState(
        paper_abstract=pa or a,
        paper_content=pc or c,
        paper_reproduced=pr or r,
        paper_favorite=fav,
        paper_topic=topic or "llm-techniques",
        paper_to_read=resolved_to_read,
    )


def display_title_from_meta(meta: dict[str, Any], rel_path: str) -> str:
    t = meta.get("title")
    if isinstance(t, str) and t.strip():
        return t.strip()
    stem = rel_path.rsplit("/", 1)[-1].removesuffix(".md")
    return stem or rel_path


def paper_reading_row_from_meta(path: str, meta: dict[str, Any]) -> PaperReadingRow:
    state = paper_metadata_from_frontmatter(meta, path=path)
    title = display_title_from_meta(meta, path)
    return PaperReadingRow(
        path=path,
        paper_abstract=state.paper_abstract,
        paper_content=state.paper_content,
        paper_reproduced=state.paper_reproduced,
        paper_favorite=state.paper_favorite,
        paper_topic=state.paper_topic,
        paper_to_read=state.paper_to_read,
        paper_title=title,
    )
