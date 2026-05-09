---
title: "\"Why Should I Trust You?\": Explaining the Predictions of Any Classifier"
authors:
  - Marco Tulio Ribeiro
  - Sameer Singh
  - Carlos Guestrin
year: 2016
venue: KDD
arxiv: "1602.04938"
url: "https://arxiv.org/abs/1602.04938"
tags: [xai, local-explanations, interpretability]
status: to-read
---

## Paper link

The viewer renders note **body** only (YAML frontmatter is hidden). Mirror the canonical landing page here—typically the same as frontmatter `url` (and `https://arxiv.org/abs/<id>` when `arxiv` is set).

- **Paper:** [https://arxiv.org/abs/1602.04938](https://arxiv.org/abs/1602.04938)

## TL;DR

**LIME:** approximate any classifier locally with an interpretable model by perturbing inputs around an instance and fitting sparse linear explanations.

## Why it matters (hype / industry / cost)

Still widely taught as the baseline **local explanation** API—easy to try on tabular/text/image modalities if perturbations make sense.

## Method

Sample perturbations → collect predictions → weighted ridge toward faithful sparse coefficients → explanation vector.

## Results

Case studies across domains; known limitations on stability/faithfulness spurred follow-on work.

## Notes / quotes

(Add while reading.)

## Open questions

Compare stability vs [[papers/shap-neurips-2017]] on the same model under [[papers/quantization-int8-jacob-2018]]?
