# Agent instructions

Read this first. Owner: **Alireza Jafartash** (CS research).

## Output

- Be **minimal**: short, dense text. No filler. Expand only if asked.

## Research filters (default lens)

When suggesting directions, weight:

1. **Compute** — assume tight budget; best case ~1× H100, not more unless stated.
2. **Hype / market** — field momentum matters.
3. **Industry** — practical adoption and industry ties matter.

## Repo conventions

| Area | Rule |
|------|------|
| Papers | **No PDFs in git.** One note per paper: `docs/papers/{slug}.md`. Track reading with **`paper_abstract`** (`UNREAD` \| `READ`), **`paper_content`** (`UNREAD` \| `READING` \| `READ` — only meaningful after abstract is read), **`paper_reproduced`** (`NO` \| `WORKING` \| `BLOCKED` \| `DONE` — only after content starts), **`paper_favorite`**. Legacy `reading_status` is migrated on sync. Mirrored to SQLite (`RESEARCH_STATE_DB`). |
| Big binaries | `assets/` + optional Git LFS; datasets later → DVC, not raw git. |
| External code | Prefer `vendor/` **submodules** or sibling repos. |
| Experiments | Only under `sandbox/<slug>/` (gitignored). Log in `AGENT_LOG.md` there. |
| Promotable results | Summarize into `docs/research/topics/...`; commit that, not raw sandbox dumps. |

## Docs

- Markdown + YAML frontmatter where templates exist (`docs/papers/_template.md`).
- Wikilinks: `[[path/to/note]]` or `[[note\|alias]]` (paths relative to `docs/`, no `.md`).
- Decisions: short ADR-style files in `docs/research/decisions/` when direction changes.

## Paper summary workflow

1. Ensure `url` or `arxiv` in frontmatter.
2. Sections: TL;DR → why it matters (hype/industry/cost) → method → results → notes → open questions.
3. Link related notes with wikilinks.

## Code / runs

- From repo root use **`make test`**, **`make lint`**, **`make serve`** (they pin `./.venv` via `UV_PROJECT_ENVIRONMENT` and `env -u VIRTUAL_ENV`; see Makefile).
- If you must invoke **`uv`/`python` directly**, use `./.venv/bin/python -m …` after **`make install`/`make dev`**, or `./scripts/with-repo-uv.sh run …`.
- Avoid relying on whichever `PYTHON`/`VIRTUAL_ENV` happens to be active in an outer shell—it may point at another project (e.g. `~/.venv`).
- Long-running or messy work: `sandbox/<experiment-slug>/` + `AGENT_LOG.md`.

## App

- Source: `src/research/`. Serve: `make serve` → `/viewer/`, OpenAPI `/docs`.
