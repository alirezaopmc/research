# research — thesis notes & documents

Markdown vault for papers and notes, plus Typst builds for the thesis proposal and weekly reports. Edit files in the repo or your editor; the only web app is the Learning Lab in `learning/`.

## Quick commands

```bash
make proposal              # build proposal PDFs (see proposal/Makefile)
make -C reports PROJECT=llm_hallucination WEEK=2026-W1   # one weekly report PDF
```

Requires `typst` (`brew install typst`). Persian proposal needs fonts in `proposal/assets/fonts/` (see `proposal/assets/fonts/README.md`).

## Learning Lab

The interactive paper lessons live in `learning/`.

```sh
cd learning
bun install --frozen-lockfile
bun run dev
```

The lobby is [Learning Lab](learning/); the active track is [Gemma Scope](learning/papers/gemma-scope/), with active recall, interactive SAE explainers, and four T4-friendly experiment protocols.

Read the learning-app [architecture](learning/ARCHITECTURE.md) and
[agent instructions](learning/AGENTS.md) before extending the site.

## Layout

```text
docs/
  papers/_template.md     Scaffold for new paper notes (no PDFs in git)
  notes/                  General notes
proposal/                 Typst thesis proposal (fa)
reports/                  Typst weekly progress reports
sandbox/                  Local experiments (gitignored except README)
assets/                   Shared static assets
```

## Paper notes

1. Copy `docs/papers/_template.md` → `docs/papers/<slug>.md`.
2. Fill frontmatter and sections; link related notes with wikilinks (`[[path/no-ext]]`).
3. Never commit PDFs — links only.

See [AGENTS.md](AGENTS.md) for agent and workflow conventions.
