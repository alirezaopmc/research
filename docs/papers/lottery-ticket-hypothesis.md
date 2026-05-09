---
title: "The Lottery Ticket Hypothesis: Finding Sparse, Trainable Neural Networks"
authors:
  - Jonathan Frankle
  - Michael Carbin
year: 2019
venue: ICLR
arxiv: "1803.03635"
url: "https://arxiv.org/abs/1803.03635"
tags: [pruning, sparsity, optimization]
status: to-read
---

## Paper link

The viewer renders note **body** only (YAML frontmatter is hidden). Mirror the canonical landing page here—typically the same as frontmatter `url` (and `https://arxiv.org/abs/<id>` when `arxiv` is set).

- **Paper:** [https://arxiv.org/abs/1803.03635](https://arxiv.org/abs/1803.03635)

## TL;DR

Dense networks contain **sparse subnetworks** (“winning tickets”) that train from initialization as well as the full model when rewound to early weights—reframes pruning as **what to train**, not only post-hoc trimming.

## Why it matters (hype / industry / cost)

Shapes how we think about **parameter efficiency** and Lottery Ticket–inspired pruning literature; connects to hardware support for unstructured vs structured sparsity.

## Method

Iterative magnitude pruning with weight rewinding / warm resets (follow-ups refine details).

## Results

Empirical MNIST/CIFAR/ImageNet-style demos in paper lineage—implementation caveats abound.

## Notes / quotes

(Add while reading.)

## Open questions

Does ticket finding survive **distillation** ([[papers/knowledge-distillation-hinton-2015]]) or aggressive quantization?
