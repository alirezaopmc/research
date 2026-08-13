# Agent instructions

Read this first. Owner: **Alireza Jafartash** (CS research).

## Output

- Be **minimal**: short, dense text. No filler. Expand only if asked.

## Research filters (default lens)

When suggesting directions, weight:

1. **Compute** — assume tight budget; Colab T4 / ~1× H100 ceiling unless stated.
2. **Hype / market** — field momentum matters.
3. **Industry** — practical adoption and industry ties matter.

## Repo conventions

| Area | Rule |
|------|------|
| Papers | **No PDFs in git.** One note per paper: `docs/papers/{slug}.md`. Optional frontmatter: `paper_abstract`, `paper_content`, `paper_reproduced`, `paper_favorite` (manual tracking in the note file). |
| Big binaries | `assets/` + optional Git LFS; datasets later → DVC, not raw git. |
| External code | Prefer `vendor/` **submodules** or sibling repos. |
| Experiments | Only under `sandbox/<slug>/` (gitignored). Log in `AGENT_LOG.md` there. |
| Promotable results | Summarize into committed markdown (paper notes, `docs/notes/`, or future thesis roadmap files); do not commit raw sandbox dumps. |

## Docs

- Markdown + YAML frontmatter where templates exist (`docs/papers/_template.md`).
- Wikilinks: `[[path/to/note]]` or `[[note\|alias]]` (paths relative to `docs/`, no `.md`).

## Paper summary workflow

1. Ensure `url` or `arxiv` in frontmatter.
2. Sections: TL;DR → why it matters (hype/industry/cost) → method → results → notes → open questions.
3. Link related notes with wikilinks.

## Builds

- Proposal: `make proposal` from repo root.
- Reports: `make -C reports PROJECT=<slug> WEEK=<YYYY-Wn>` (see `reports/Makefile`).

## Experiments

Long-running or messy work: `sandbox/<experiment-slug>/` + `AGENT_LOG.md`.
