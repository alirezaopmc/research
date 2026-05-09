---
title: "Dataset Cartography: Mapping and Diagnosing Datasets with Training Dynamics"
authors:
  - Swabha Swayamdipta et al.
year: 2020
venue: EMNLP
arxiv: "2009.10795"
url: "https://arxiv.org/abs/2009.10795"
tags: [data-centric, training-dynamics, nlp]
status: to-read
---

## Paper link

The viewer renders note **body** only (YAML frontmatter is hidden). Mirror the canonical landing page here—typically the same as frontmatter `url` (and `https://arxiv.org/abs/<id>` when `arxiv` is set).

- **Paper:** [https://arxiv.org/abs/2009.10795](https://arxiv.org/abs/2009.10795)

## TL;DR

Plots examples by **confidence** and **variability** during training to reveal **easy / ambiguous / hard** regions—diagnostic tool for dataset quality beyond aggregate loss.

## Why it matters (hype / industry / cost)

Complements Confident Learning with **process** insight: where models disagree with themselves over training. Useful for prioritizing relabeling/collection.

## Method

Track per-example correctness and volatility across epochs; cluster into cartography regions.

## Results

Demonstrates improved model behavior when leveraging cartography for training decisions.

## Notes / quotes

(Add while reading.)

## Open questions

Transfer ideas from NLP classification to **vision** or **tabular** with analogous training traces?
