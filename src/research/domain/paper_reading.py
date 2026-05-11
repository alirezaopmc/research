from __future__ import annotations

from typing import Any, Literal

from pydantic import BaseModel, model_validator

type PaperAbstractStatus = Literal["UNREAD", "READ"]
type PaperContentStatus = Literal["UNREAD", "READING", "READ"]
type PaperReproducedStatus = Literal["NO", "WORKING", "BLOCKED", "DONE"]

PAPER_ABSTRACT_CHOICES: tuple[PaperAbstractStatus, ...] = ("UNREAD", "READ")
PAPER_CONTENT_CHOICES: tuple[PaperContentStatus, ...] = ("UNREAD", "READING", "READ")
PAPER_REPRODUCED_CHOICES: tuple[PaperReproducedStatus, ...] = (
    "NO",
    "WORKING",
    "BLOCKED",
    "DONE",
)

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
            )
        if co == "UNREAD":
            if re == "NO":
                return self
            return PaperMetadataState.model_construct(
                paper_abstract=ab,
                paper_content="UNREAD",
                paper_reproduced="NO",
                paper_favorite=self.paper_favorite,
            )
        return self


class PaperReadingRow(BaseModel):
    path: str
    paper_abstract: PaperAbstractStatus
    paper_content: PaperContentStatus
    paper_reproduced: PaperReproducedStatus
    paper_favorite: bool
    paper_title: str = ""

    model_config = {"frozen": True}


class PaperFavoriteEntry(BaseModel):
    path: str
    title: str

    model_config = {"frozen": True}


def paper_metadata_from_frontmatter(meta: dict[str, Any]) -> PaperMetadataState:
    """Build metadata from YAML; maps legacy reading_status / booleans."""
    pa = _parse_abstract(meta)
    pc = _parse_content(meta)
    pr = _parse_reproduced(meta)
    fav = _truthy_legacy(meta.get("paper_favorite"))

    if pa is not None and pc is not None and pr is not None:
        return PaperMetadataState(
            paper_abstract=pa,
            paper_content=pc,
            paper_reproduced=pr,
            paper_favorite=fav,
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
    return PaperMetadataState(
        paper_abstract=pa or a,
        paper_content=pc or c,
        paper_reproduced=pr or r,
        paper_favorite=fav,
    )


def display_title_from_meta(meta: dict[str, Any], rel_path: str) -> str:
    t = meta.get("title")
    if isinstance(t, str) and t.strip():
        return t.strip()
    stem = rel_path.rsplit("/", 1)[-1].removesuffix(".md")
    return stem or rel_path


def paper_reading_row_from_meta(path: str, meta: dict[str, Any]) -> PaperReadingRow:
    state = paper_metadata_from_frontmatter(meta)
    title = display_title_from_meta(meta, path)
    return PaperReadingRow(
        path=path,
        paper_abstract=state.paper_abstract,
        paper_content=state.paper_content,
        paper_reproduced=state.paper_reproduced,
        paper_favorite=state.paper_favorite,
        paper_title=title,
    )
