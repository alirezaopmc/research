# research — notes & doc server

Local-first markdown notes, FastAPI `/api/*`, minimal `/viewer` (htmx).

## Setup

```bash
uv sync --all-extras
```

## Run

```bash
make serve
```

Open `http://127.0.0.1:8000/viewer/`. API: `http://127.0.0.1:8000/docs`.

## Layout

- `docs/` — markdown vault (papers: links only; no PDFs in git)
- `src/research/` — app code
- `sandbox/` — local experiments (gitignored except `README.md`)

See [AGENTS.md](AGENTS.md).
