---
title: "Quantization and Training of Neural Networks for Efficient Integer-Arithmetic-Only Inference"
authors:
  - Benoit Jacob et al.
year: 2018
venue: CVPR
arxiv: "1712.05877"
url: "https://arxiv.org/abs/1712.05877"
tags: [quantization, int8, deployment]
status: to-read
---

## Paper link

The viewer renders note **body** only (YAML frontmatter is hidden). Mirror the canonical landing page here—typically the same as frontmatter `url` (and `https://arxiv.org/abs/<id>` when `arxiv` is set).

- **Paper:** [https://arxiv.org/abs/1712.05877](https://arxiv.org/abs/1712.05877)

## TL;DR

**Quantization-aware training** and integer-only inference pipeline for CNNs—foundation for INT8 deployment paths (Gemmlowp-era framing; concepts persist).

## Why it matters (hype / industry / cost)

Quantization is how many edge/cloud stacks cut memory and throughput costs without linear scaling in model size. Essential literacy for TinyML-adjacent deployment.

## Method

Simulated low-precision arithmetic during training; integer kernels at inference with learned scales/zero-points.

## Results

Strong ImageNet accuracy retention with INT8 inference in the paper’s setting—verify on your arch + framework.

## Notes / quotes

(Add while reading.)

## Open questions

Faithfulness of [[research/topics/explainable-ai|XAI]] methods under simulated vs real INT8—worth a later experiment note.
