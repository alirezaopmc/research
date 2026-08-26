---
title: "The Geometry of Truth: Emergent Linear Structure in Large Language Model Representations"
authors: "Samuel Marks, Max Tegmark (MIT)"
year: 2023
venue: arXiv
arxiv: "2310.06824"
url: "https://arxiv.org/abs/2310.06824"
tags: ["truth", "probing", "geometry", "hallucination"]
topic: "Linear representation of truth in LLMs"
paper_abstract: UNREAD
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: true
paper_to_read: true
---

## Paper link

- **Paper:** [arXiv:2310.06824](https://arxiv.org/abs/2310.06824)

## TL;DR

Shows that truthfulness of factual statements is linearly represented in LLM activation space, generalizable across diverse domains and prompt formulations.

## Why it matters (hype / industry / cost)

- **Compute:** Extremely lightweight to reproduce via PCA / Logistic Regression probes on raw layer activations.
- **Hype / market:** Foundational work cited in almost all internal factuality probing literature.
- **Industry:** Groundwork for real-time truth monitors.
- **Topic fit:** Serves as our primary baseline comparison: do SAE features outperform raw linear probes in AUROC / OOD generalization?

## Method

- Curated datasets of true/false pairs across multiple topics (geography, math, facts).
- Applied Difference-in-Means, PCA, and Logistic Regression probing across all layers.

## Results

- Found linear "truth directions" in middle and late layers with high classification accuracy across test sets.

## Notes / quotes

- Core baseline reference in [[notes/research-strategy]].

## Open questions

- Does the linear truth direction conflate true belief with mere surface plausibility or familiarity? Can SAEs disentangle this?
