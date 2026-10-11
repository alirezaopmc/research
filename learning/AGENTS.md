# Learning Lab Agent Instructions

These instructions apply to work inside `learning/`. The repository-level
[`../AGENTS.md`](../AGENTS.md) remains authoritative for research, sandbox,
paper, and output rules.

## Purpose

`learning/` is a static-first, content-driven site for mastering research
papers and turning them into small, reproducible experiments. Keep the active
track focused: the current track is the original Gemma Scope release for
Gemma 2. Gemma Scope 2/Gemma 3 is a separate future track.

## Stack and commands

- Astro 7.3.1 generates static HTML.
- `@astrojs/alpinejs` and Alpine.js 3.17.1 power small client-side islands.
- `@astrojs/mdx` 7.0.8 provides collection-backed MDX authoring.
- Bun 1.3+ manages dependencies and scripts.
- TypeScript 5.9.3 provides type checking.
- Biome 2.5.12 formats and lints source files.
- Plain CSS owns the visual system; do not add Tailwind, a UI kit, or a
  component runtime without a design decision.

Run from this directory:

```sh
bun install --frozen-lockfile
bun run dev
bun run astro:check
bun run quality
bun run build
```

`astro:check`, Biome, and the production build are the quality gates. There is
no test framework; interactive behavior is browser-verified.

## Content authoring

`src/content.config.ts` owns schemas. Content entries under `src/content/` are
the source of truth; route templates must query collections rather than copy
paper facts or experiment instructions.

- `papers/*.md`: paper-track metadata, stats, and source map.
- `lessons/<paper-slug>/*.mdx`: one chapter per entry, with stable `id` and
  validated learning metadata.
- `experiments/<paper-slug>/*.mdx`: one standalone runway protocol per entry.

Every factual claim needs a source link. Keep paper-reported results,
reproducible local checks, and thesis hypotheses visibly distinct.

Experiment pages are detailed Colab scaffolds: setup, explicit configuration,
cell-by-cell pseudocode, checks, artifacts, failure modes, stop conditions,
and handoff criteria. Do not commit notebooks, raw datasets, checkpoints, or
unexecuted claims.

## Routing and components

- `/` is the lobby.
- `/papers/<paper-slug>/` is the paper lesson.
- `/papers/<paper-slug>/experiments/<experiment-slug>/` is a runway protocol.

Use `getCollection`, `getEntry`, `render`, and `getStaticPaths` for static
routes. Preserve stable IDs and slugs when editing content.

`LearningLayout.astro` owns document chrome. Astro components own static
structure and paper-specific instruments. Alpine owns only progress, quizzes,
study context, tabs, and experiment completion. New client state must have a
namespaced localStorage key and a no-storage fallback.

## Interface conventions

- Keep the editorial navy/gold visual language and Crimson Pro/Atkinson
  Hyperlegible type pairing.
- Prefer semantic HTML, native controls, visible focus, descriptive labels,
  and text alternatives to color-only state.
- Maintain readable text measure and responsive layouts at 375px, 768px,
  1024px, and 1440px.
- Respect `prefers-reduced-motion`; animations should explain state or
  navigation and use transform/opacity rather than layout reflow.
- Sticky UI must not obscure anchors or keyboard focus.
- Do not use hover as the only way to discover or operate a control.

## Experiment handoff

Before changing an experiment, read the relevant paper note,
`docs/notes/research-strategy.md`, and
`docs/notes/gemma-scope-learning-roadmap.md`. Put long-running work under
`sandbox/<experiment-slug>/`, start or update `AGENT_LOG.md`, expose model/SAE
IDs, layer, site, dataset slice, seed, device, and dtype, and stop at the first
failed invariant. Promote only compact reproducible results to Markdown.
