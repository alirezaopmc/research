---
title: "MobileNets: Efficient Convolutional Neural Networks for Mobile Vision Applications"
authors:
  - Andrew G. Howard et al.
year: 2017
venue: arXiv
arxiv: "1704.04861"
url: "https://arxiv.org/abs/1704.04861"
tags: [architecture, mobile, efficiency]
status: to-read
---

## Paper link

The viewer renders note **body** only (YAML frontmatter is hidden). Mirror the canonical landing page here—typically the same as frontmatter `url` (and `https://arxiv.org/abs/<id>` when `arxiv` is set).

- **Paper:** [https://arxiv.org/abs/1704.04861](https://arxiv.org/abs/1704.04861)

## TL;DR

**Depthwise separable convolutions** plus width/resolution multipliers yield accurate vision models with far fewer multiply-adds—classic mobile-efficient backbone family.

## Why it matters (hype / industry / cost)

Industry default mental model for **latency-first CV**: architectural efficiency before aggressive pruning. Implementations exist in every major framework.

## Method

Factor standard convolutions into depthwise + pointwise blocks; expose hyperparameters for accuracy–latency tradeoffs.

## Results

Strong accuracy vs cost on ImageNet-scale tasks at publication time; still a pedagogical baseline.

## Notes / quotes

(Add while reading.)

## Open questions

Compare MobileNet-style blocks vs modern efficient transformers / ConvNeXt-tiny variants for your task budget.
