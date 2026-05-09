---
title: "Confident Learning: Estimating Uncertainty in Dataset Labels"
authors:
  - Curtis G. Northcutt
  - Lu Jiang
  - Isaac L. Chuang
year: 2021
venue: JAIR
arxiv: "1911.00068"
url: "https://arxiv.org/abs/1911.00068"
tags: [label-noise, data-centric, cleaning]
status: to-read
---

## Paper link

The viewer renders note **body** only (YAML frontmatter is hidden). Mirror the canonical landing page here—typically the same as frontmatter `url` (and `https://arxiv.org/abs/<id>` when `arxiv` is set).

- **Paper:** [https://arxiv.org/abs/1911.00068](https://arxiv.org/abs/1911.00068)

## TL;DR

Joint estimation of **label errors** and cleaned probabilities using predicted versus noisy labels—practical algorithms for dataset auditing under noise.

## Why it matters (hype / industry / cost)

Operational bridge from **data-centric AI** rhetoric to code you can run before expensive training iterations; strong fit for academic setups without giant clusters.

## Method

Counts-based / confusion-matrix style correction with pruning of likely mislabeled examples (see paper for exact procedures).

## Results

Benchmarked label-error detection across settings—validate on your domain.

## Notes / quotes

(Add while reading.)

## Open questions

Interaction with **slice imbalance**: does confident learning hide minority-class blind spots?
