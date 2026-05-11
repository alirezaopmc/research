# research — notes & doc server

Local-first markdown notes, FastAPI `/api/*`, minimal `/viewer` (htmx).

## Setup

Use the **virtualenv in this repo** (`./.venv`). Prefer **`make`** (`make dev`, `make test`, `make serve`); targets set **`UV_PROJECT_ENVIRONMENT`** and clear a stray **`VIRTUAL_ENV`** so `uv` uses this project’s interpreter, not another activated venv.

```bash
make dev           # wraps: uv sync --all-extras
make test && make lint
make serve         # wraps: uv run python -m research.api.cli
```

If you run **`uv`** yourself instead of **`make`** (e.g. in CI shells), invoke it from repo root **after**:

```bash
export UV_PROJECT_ENVIRONMENT="$(pwd)/.venv"
unset VIRTUAL_ENV
uv sync --all-extras && uv run pytest -q
```

Or wrap any `uv …` invocation with `./scripts/with-repo-uv.sh` (same env as `make`).


## Run

```bash
make serve
```

Open `http://127.0.0.1:8000/viewer/`. API: `http://127.0.0.1:8000/docs`.

Search uses **SQLite FTS5** on startup (index under `.research/`, gitignored). Override path with `RESEARCH_SEARCH_DB` if needed.

**Papers:** set **`paper_abstract`**, **`paper_content`**, **`paper_reproduced`**, and **`paper_favorite`** in frontmatter (legacy **`reading_status`** is still mapped on load but replaced on save via the viewer). Values are mirrored into **`RESEARCH_STATE_DB`** on startup. The `/viewer` **Paper** panel updates them with `PATCH /api/papers/{path}`.

Override the state DB with **`RESEARCH_STATE_DB`** when needed.

## Layout

- `docs/` — markdown vault (papers: links only; no PDFs in git)
- `src/research/` — app code
- `sandbox/` — local experiments (gitignored except `README.md`)

See [AGENTS.md](AGENTS.md).
