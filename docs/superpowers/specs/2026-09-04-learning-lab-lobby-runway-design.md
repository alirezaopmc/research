# Learning Lab Lobby and Runway

## Goal

Turn the first Gemma Scope learning page into the first track in a reusable
research learning lab. The root route is a lobby; the Gemma 2 lesson and each
experiment gate have stable, shareable URLs.

## Scope

### Routes

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

The current lesson moves from `/` to `/papers/gemma-scope/`. The root becomes
the lobby and links to the track, experiment pages, primary sources, and future
tracks.

### Content model

Astro Content Layer is the authoring boundary:

- `papers`: one entry per paper track with title, description, stats, source
  links, and ordering metadata.
- `lessons`: one MDX entry per chapter with validated navigation metadata,
  learning cues, source link, quiz data, and optional interactive content.
- `experiments`: one MDX entry per runway gate with validated route metadata
  and a detailed instructional body.

`src/content.config.ts` owns the schemas. `src/content/` owns the authored
content. Page templates query collections and do not duplicate paper facts or
experiment copy.

Lesson and experiment bodies use MDX so interactive Astro components can be
placed next to the explanation. The first pass does not add a CMS, remote
loader, runtime content fetch, or notebook files.

## Architecture

```text
MDX + frontmatter
        |
        v
Content Layer + Zod validation
        |
        v
Astro getCollection/getEntry + getStaticPaths
        |
        +--> lobby
        +--> paper lesson shell
        +--> experiment guide shell
        |
        v
Static HTML and CSS
        |
        v
Alpine islands for progress, quizzes, and small instruments
```

### Shared shell

`LearningLayout.astro` owns document metadata, global stylesheet loading,
skip-link behavior, consistent top navigation, breadcrumbs, and footer
structure. Page templates own their page-specific content and call-to-action
composition. Existing interactive components remain Astro components; they do
not become framework-wide client applications.

### Progress

Lesson progress continues to use a paper-scoped localStorage key and stable
chapter IDs. Experiment completion uses a separate experiment-scoped key so
preparing a notebook does not look like mastering a paper chapter. Storage is
convenience state: reading, navigation, and content remain functional without
JavaScript or available storage.

### Research boundaries

The active track is the original Gemma Scope release for Gemma 2. Its first
experiment uses one Gemma 2 2B model, one canonical residual-stream SAE, a
small input slice, and inference-only checks. The page content separates:

1. paper-reported facts;
2. locally reproducible wiring and measurement checks;
3. thesis hypotheses requiring controlled evidence.

Gemma Scope 2 is a separate future track for Gemma 3. It includes SAEs and
transcoders and has different tooling and model coverage; it is not mixed into
the Gemma 2 instructions.

## Runway contracts

### A — Wire the microscope

Purpose: prove that model, hook/site, SAE, dtype, device, and tensor shapes
agree before collecting results.

Colab scaffold: install pinned-enough dependencies, expose model/SAE/layer/site
configuration, run CPU shape checks, move to a tiny GPU slice, compute mean L0,
reconstruction error, activation norms, runtime, and peak memory, then write an
`AGENT_LOG.md` entry. Stop on any shape, norm, L0, reconstruction, or memory
invariant failure.

### B — Find features worth testing

Purpose: inspect whether candidate features have coherent activating contexts
before attaching a semantic label.

Colab scaffold: reuse the validated pipeline, collect top activating examples
for 10–20 features, stratify by activation strength, inspect token position and
frequency effects, add semantically close non-activating examples, and maintain
a feature ledger. Stop when a proposed label is supported only by one example,
one topic, or one position.

### C — Run the fair comparison

Purpose: test whether SAE decomposition adds signal beyond a raw hidden-state
probe.

Colab scaffold: build a small true/false slice with topic and negation
variation, freeze an explicit split and seed, collect matched raw activations
and SAE features at the same site, fit comparable lightweight probes, and
report AUROC, AUPR, F1, calibration, runtime, memory, and split details. Stop
on leakage, unequal sample handling, or a missing raw-state baseline.

### D — Earn intervention

Purpose: test causal usefulness only after detection and feature selection
survive held-out evaluation.

Colab scaffold: select candidate features using training data only, reserve a
held-out set, intervene at fixed strengths, measure factuality and capability
side effects, compare against a no-intervention control, and record failures
and environment details. Stop if the effect is not dose-responsive,
reproducible, or separated from a broader quality change.

## Visual and interaction direction

Use the existing scholarly editorial language: institutional navy, citation
gold, Crimson Pro display type, Atkinson Hyperlegible body/interface text,
modular grids, readable measures, and restrained motion. The lobby should feel
like a research library index; paper pages should feel like a guided notebook;
experiment pages should feel like lab protocols.

All routes need visible focus, keyboard access, semantic headings, responsive
behavior at 375px/768px/1024px/1440px, no hover-only meaning, and
`prefers-reduced-motion` support. Deep links and breadcrumbs are required for
the three-level experiment pages.

## Explicit exclusions

- No server, database, accounts, analytics, comments, payments, or SaaS
  backend.
- No browser-executed notebooks or committed `.ipynb` files.
- No custom SAE training.
- No claim that Gemma Scope itself detects hallucinations.
- No migration of the research vault into the learning app.
- No second Gemma Scope 2 content track in this implementation.
