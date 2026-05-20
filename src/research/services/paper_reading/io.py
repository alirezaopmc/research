"""Read/write paper metadata in Markdown frontmatter (authoritative)."""

from __future__ import annotations

from pathlib import Path

import yaml

from research.domain.paper_reading import PaperMetadataState
from research.services.notes import normalize_rel, split_frontmatter

_LEGACY_KEYS_DROP = frozenset(
    {
        "read_abstract",
        "read_all",
        "reproduced",
        "status",
        "reading_status",
    }
)


def write_paper_metadata(docs: Path, rel_path: str, state: PaperMetadataState) -> str:
    """
    Persist paper_* fields in docs/papers/<slug>.md; strip legacy keys.
    Returns normalized vault-relative posix path.
    """
    rel = normalize_rel(rel_path)
    p = (docs / rel).resolve()
    docs_r = docs.resolve()
    if not str(p).startswith(str(docs_r)) or not p.is_file():
        msg = f"paper note not found: {rel_path}"
        raise FileNotFoundError(msg)
    if not rel.startswith("papers/") or p.name == "_template.md":
        msg = f"not an editable paper path: {rel}"
        raise ValueError(msg)

    state = PaperMetadataState.model_validate(state.model_dump())

    raw = p.read_text(encoding="utf-8")
    meta, body = split_frontmatter(raw)
    for k in _LEGACY_KEYS_DROP:
        meta.pop(k, None)
    meta["paper_abstract"] = state.paper_abstract
    meta["paper_content"] = state.paper_content
    meta["paper_reproduced"] = state.paper_reproduced
    meta["paper_favorite"] = state.paper_favorite
    meta["topic"] = state.paper_topic
    meta["paper_to_read"] = state.paper_to_read

    fm = yaml.safe_dump(
        meta,
        default_flow_style=False,
        sort_keys=False,
        allow_unicode=True,
    ).rstrip("\n")

    sep = "\n" if body and not body.startswith("\n") else ""
    new_raw = f"---\n{fm}\n---\n{sep}{body}"
    p.write_text(new_raw, encoding="utf-8")
    return rel
