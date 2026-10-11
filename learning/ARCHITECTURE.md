# Learning Lab Architecture

## Product boundary

Learning Lab is a static research-reading site. It turns paper notes into
guided lessons and experiment protocols. It does not run notebooks, store
accounts, train models, or provide a SaaS backend.

## Route map

```text
/
└── papers/
    └── gemma-scope/
        ├── index
        └── experiments/
            ├── a-wire-the-microscope
            ├── b-find-features
            ├── c-fair-comparison
            └── d-earn-intervention
```

The root is a library lobby. The paper route is the guided reading surface.
The four experiment routes are deep-linkable Colab protocols.

## Data flow

```text
src/content/*.md(x)
        ↓
src/content.config.ts (Content Layer + Zod)
        ↓
getCollection/getEntry + render
        ↓
Astro layouts and route templates
        ↓
static HTML/CSS
        ↓
Alpine only for local state and small instruments
```

## Content collections

### `papers`

One Markdown entry per paper track. It owns title, description, abstract,
stats, primary source, and related sources.

### `lessons`

One MDX entry per chapter. Frontmatter owns stable route state:
`paperSlug`, `id`, `order`, `number`, `kicker`, `title`, `summary`, `idea`,
`bullets`, learning cues, source, and quiz data. The body is the small
chapter-specific extension point. Interactive instruments are selected by the
stable lesson ID and remain reusable Astro components.

### `experiments`

One MDX entry per protocol. Frontmatter owns route metadata, status, effort,
compute target, prerequisites, resources, stop conditions, artifacts, and
next-page metadata. The body owns the detailed Colab scaffold.

This keeps route generation and navigation typed while allowing long-form
research instructions to be edited as Markdown/MDX.

## Component boundaries

- `LearningLayout.astro`: document head, global script/style loading, skip
  link, top bar, footer, and shared home link.
- `ExperimentCard.astro`: lobby and paper-route link card for a runway entry.
- `LessonSection.astro`: chapter metadata, cues, completion control, source,
  quiz, and lesson-specific visual instruments.
- `ExperimentGuide.astro`: protocol hero, prerequisites, artifacts, rendered
  MDX, stop conditions, resources, completion state, and previous/next links.
- `Quiz.astro`: active-recall interaction and answer feedback.
- `JumpReluPlayground.astro`: threshold/gating visual.
- `SiteExplorer.astro`: site-selection visual with keyboard tabs.
- `learning.ts`: Alpine registrations, reveal behavior, and local persistence.

Astro owns the page and content structure. Alpine is not a global application.
Avoid adding a framework runtime for static markup.

## Local state

Paper chapters use:

```text
learning-lab:<paper-slug>:v1
```

Experiment preparation uses:

```text
learning-lab:<paper-slug>:experiment:<experiment-slug>:v1
```

Storage failures are ignored. A user can still read, navigate, and run the
protocol without JavaScript or localStorage.

## Visual system

The interface uses a scholarly editorial language: navy and paper surfaces,
citation gold, teal for positive protocol states, Crimson Pro for display
hierarchy, and Atkinson Hyperlegible for body/interface copy. CSS variables,
plain CSS, inline SVG/HTML visuals, and restrained transform/opacity motion
keep the build small and portable.

Use one primary action per view, stable navigation placement, breadcrumbs on
deep routes, readable code blocks, visible focus, semantic headings, and
responsive layouts at 375px, 768px, 1024px, and 1440px. Always test reduced
motion and keyboard operation.

## Research contract

The active track teaches the 2024 Gemma Scope release for Gemma 2. Its
experiment runway is:

1. wire one canonical residual-stream SAE;
2. inspect candidate features and close counterexamples;
3. compare matched raw-state and SAE-feature probes;
4. test held-out intervention and side effects.

Gemma Scope 2 is a separate future Gemma 3 track. Never mix its transcoders,
model IDs, runtime, or claims into the Gemma 2 instructions.

## Documentation ownership

- `learning/AGENTS.md`: instructions for work inside the learning app.
- `learning/ARCHITECTURE.md`: current route, data, component, state, and
  visual architecture.
- `learning/README.md`: quick start and authoring summary.
- `docs/notes/gemma-scope-learning-roadmap.md`: research runway and experiment
  handoff contract.
- `docs/superpowers/specs/`: dated design decisions and scope boundaries.
- `sandbox/<slug>/AGENT_LOG.md`: raw experiment environment and results.

When these documents disagree, update the architecture/spec record first, then
align the quick-start and roadmap indexes.
