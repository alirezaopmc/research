# research — thesis notes & documents

Markdown vault for papers and notes, plus Typst builds for the thesis proposal and weekly reports. No web viewer — edit files in the repo or your editor.

## Quick commands

```bash
make proposal              # build proposal PDFs (see proposal/Makefile)
make -C reports PROJECT=llm_hallucination WEEK=2026-W1   # one weekly report PDF
```

Requires `typst` (`brew install typst`). Persian proposal needs fonts in `proposal/assets/fonts/` (see `proposal/assets/fonts/README.md`).

## Layout

```text
docs/
  papers/_template.md     Scaffold for new paper notes (no PDFs in git)
  notes/                  General notes
proposal/                 Typst thesis proposal (fa + en)
reports/                  Typst weekly progress reports
sandbox/                  Local experiments (gitignored except README)
assets/                   Shared static assets
```

## Paper notes

1. Copy `docs/papers/_template.md` → `docs/papers/<slug>.md`.
2. Fill frontmatter and sections; link related notes with wikilinks (`[[path/no-ext]]`).
3. Never commit PDFs — links only.

See [AGENTS.md](AGENTS.md) for agent and workflow conventions.
