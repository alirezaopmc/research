# Learning Lab

Reusable, static-first paper lessons for the research vault. The current
active track is the original Gemma Scope release for Gemma 2.

## Routes

- `/` — research learning-lab lobby.
- `/papers/gemma-scope/` — guided paper journey.
- `/papers/gemma-scope/experiments/a-wire-the-microscope/` — pipeline smoke test.
- `/papers/gemma-scope/experiments/b-find-features/` — feature discovery ledger.
- `/papers/gemma-scope/experiments/c-fair-comparison/` — raw vs. SAE probe.
- `/papers/gemma-scope/experiments/d-earn-intervention/` — held-out intervention.

## Commands

Run from this directory:

```sh
bun install --frozen-lockfile
bun run dev
bun run astro:check
bun run quality
bun run build
```

Use `bun run preview` to inspect the built site locally.

## Authoring

Astro Content Layer and MDX entries under `src/content/` are the source of
truth. `src/content.config.ts` validates:

- paper metadata in `content/papers/*.md`;
- chapter metadata and active-recall quizzes in `content/lessons/**/*.mdx`;
- experiment metadata and Colab scaffold protocols in
  `content/experiments/**/*.mdx`.

Stable IDs and slugs are part of the URL/progress contract. See
[ARCHITECTURE.md](ARCHITECTURE.md) and [AGENTS.md](AGENTS.md) before editing.

## Learning interface

Alpine powers local progress, quizzes, the JumpReLU threshold instrument, site
tabs, experiment completion, and scroll-aware study context. Motion is
restrained, content remains readable without JavaScript, and
`prefers-reduced-motion` removes reveal transitions.

Experiment pages provide detailed instructions and pseudocode for Google Colab.
They do not execute notebooks or commit `.ipynb` files.

## Research boundary

Gemma Scope 2 is a separate future Gemma 3 track. Do not mix its transcoders,
model IDs, or runtime assumptions into the current Gemma 2 runway.
