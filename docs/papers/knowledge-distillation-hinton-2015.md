---
title: "Distilling the Knowledge in a Neural Network"
authors:
  - Geoffrey Hinton
  - Oriol Vinyals
  - Jeff Dean
year: 2015
venue: arXiv (widely cited distillation paper)
arxiv: "1503.02531"
url: "https://arxiv.org/abs/1503.02531"
tags: [distillation, compression, efficiency]
status: to-read
---

## Paper link

The viewer renders note **body** only (YAML frontmatter is hidden). Mirror the canonical landing page here—typically the same as frontmatter `url` (and `https://arxiv.org/abs/<id>` when `arxiv` is set).

- **Paper:** [https://arxiv.org/abs/1503.02531](https://arxiv.org/abs/1503.02531)

## TL;DR

Train a smaller **student** network using soft targets from a larger **teacher** (“dark knowledge”), improving student accuracy vs training only on hard labels.

## Why it matters (hype / industry / cost)

Still the conceptual backbone for **model compression** pipelines in production (teacher–student, logits matching). Cheap to experiment with relative to architecture search.

## Method

Match softened probability distributions (temperature-scaled softmax) between teacher and student; optionally blend with ground-truth labels.

## Results

(Classic reference; empirics vary by domain—fill after your reproduction.)

## Notes / quotes

(Add while reading.)

## Open questions

How does distillation interact with later **quantization** ([[papers/quantization-int8-jacob-2018]]) in your stack?
