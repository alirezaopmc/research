---
title: "A Unified Approach to Interpreting Model Predictions"
authors:
  - Scott M. Lundberg
  - Su-In Lee
year: 2017
venue: NeurIPS
arxiv: "1705.07874"
url: "https://arxiv.org/abs/1705.07874"
tags: [xai, shapley, interpretability]
status: to-read
---

## Paper link

The viewer renders note **body** only (YAML frontmatter is hidden). Mirror the canonical landing page here—typically the same as frontmatter `url` (and `https://arxiv.org/abs/<id>` when `arxiv` is set).

- **Paper:** [https://arxiv.org/abs/1705.07874](https://arxiv.org/abs/1705.07874)

## TL;DR

**SHAP** connects additive feature attribution with Shapley values from cooperative games, unifying several prior explanation methods under one framework.

## Why it matters (hype / industry / cost)

Deployed widely where regulators/product ask for **feature attributions** (tabular models especially); compute cost can be non-trivial—important engineering constraint.

## Method

Define characteristic functions over feature subsets; approximate Shapley values efficiently (Kernel SHAP, TreeSHAP, etc.).

## Results

Strong empirical alignment with desired axioms; practical approximations vary by model class.

## Notes / quotes

(Add while reading.)

## Open questions

When SHAP disagrees with human error analysis ([[papers/dataset-cartography]]), which side do you trust first?
