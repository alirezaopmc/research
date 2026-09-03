# Gemma Scope Learning Lab Design

## Goal

Create a calm, interactive learning environment that helps a researcher master *Gemma Scope: Open Sparse Autoencoders Everywhere All At Once on Gemma 2*, then move into a small, reproducible implementation and experiment sequence.

The first version is a static site for local use and deployment to a personal website. It is not an AI tutor, notebook runner, account system, or SaaS backend.

## Audience and learning contract

The primary user is a machine-learning researcher with a constrained compute budget who wants to understand the paper deeply enough to reproduce a small part of its method and connect it to a hallucination-detection thesis.

Every lesson should answer four questions:

1. What is the idea?
2. What is the smallest useful mental model?
3. What can be checked or manipulated?
4. What should be implemented next?

The page uses short sections, progressive disclosure, active recall, and a persistent local mastery ledger. It should never imply that completing a quiz proves scientific understanding.

## Content scope

The learning journey covers:

1. Orientation and the paper’s contribution.
2. Activations, dictionaries, sparsity, superposition, and monosemanticity.
3. SAE encoder/decoder mechanics.
4. JumpReLU thresholds, direct L0 regularization, and STE/KDE bandwidth.
5. Gemma Scope’s model/site/width coverage and training infrastructure.
6. Evaluation: delta LM loss, FVU, sequence position, feature splitting, interpretability, base-to-IT transfer, data subsets, and bfloat16.
7. Critical reading: evidence, limits, and open problems.
8. A T4-friendly implementation runway using pretrained SAE weights.
9. A research roadmap tied to the thesis questions.
10. A handoff contract for future agents working on notes and experiments.

Primary facts are sourced from the paper and the existing repository note. Related context comes from *Jumping Ahead*, *Scaling Monosemanticity*, *The Geometry of Truth*, *Language Models (Mostly) Know What They Know*, and *Representation Engineering*. Claims about implementation links point to official or primary sources.

## Architecture

Use an isolated Astro site under `learning/`:

- Astro renders content and produces static HTML by default.
- A typed paper-content schema keeps the lesson shell reusable for later papers.
- Alpine.js powers only interactive islands: navigation, quizzes, playgrounds, and local progress.
- Bun manages dependencies, scripts, and the committed `bun.lock`.
- Biome formats and lints TypeScript, JSON, and CSS. Astro-file full support is opt-in and experimental; Astro’s own checker remains authoritative for Astro semantics.
- Plain CSS and inline SVG provide the visual system and diagrams. No UI kit, chart package, React runtime, or Tailwind layer is needed.

The persistence boundary is intentionally small:

```text
lesson content -> Astro page -> Alpine state -> progress adapter -> localStorage
                                                      |
                                                      +-> future account/API adapter
```

The first adapter stores namespaced progress only. Future cloud sync can replace the adapter without changing the lesson data or visual components.

## Product direction

Use a content-first editorial layout with a scholarly navy and citation-gold palette. Crimson Pro supplies display hierarchy; Atkinson Hyperlegible supplies body and interface text. The page should feel like a research notebook with an instrument panel, not a generic dashboard.

The memorable interaction is the JumpReLU threshold playground: changing a threshold visibly changes which latents are active while preserving the magnitudes of latents that remain above threshold. The page should connect this small visual to the paper’s larger sparsity-fidelity argument.

## Interaction and accessibility

- Sticky chapter navigation with current section and completion state.
- Lesson cards with one concept, one visual/equation, one implication, and one recall check.
- Threshold slider with a text-equivalent live explanation.
- Transformer-site selector for attention, MLP, and residual stream.
- Inline fidelity/sparsity visual that distinguishes FVU from downstream delta LM loss.
- Quiz feedback with retry and persisted answers.
- Keyboard operation for every control, visible focus, semantic landmarks, labels, and no hover-only meaning.
- Minimum 44px interactive targets, readable measure, strong contrast, long-identifier wrapping, responsive layouts at 375px, 768px, 1024px, and 1440px.
- Respect `prefers-reduced-motion`.

## Implementation runway

The first experiment is deliberately narrow:

1. Use Gemma 2 2B and one canonical residual-stream SAE.
2. Load pretrained weights with SAE Lens.
3. Run a small activation reconstruction smoke test.
4. Inspect top activating examples for a few features.
5. Compare a raw hidden-state probe with an SAE-feature probe on a small true/false slice.
6. Record memory, runtime, metrics, and failure modes under `sandbox/<experiment-slug>/AGENT_LOG.md`.
7. Promote only conclusions and reproducible commands to committed Markdown.

The site must distinguish paper-reported results from hypotheses proposed for the user’s thesis. It should not claim that Gemma Scope itself detects hallucinations; the paper releases infrastructure that makes such experiments more feasible.

## Explicit exclusions for v1

- No PDF files.
- No server, database, authentication, payments, comments, or analytics.
- No AI-generated tutoring loop.
- No live notebook execution from the browser.
- No custom SAE training.
- No broad literature survey embedded into the page.
- No framework-specific design system that prevents embedding the built output elsewhere.
