---
slug: gemma-scope
series: "Interpretability field guide · 01"
title: "Gemma Scope"
dek: "A guided path from sparse features to a first reproducible SAE experiment."
abstract: "Gemma Scope is an open suite of JumpReLU sparse autoencoders trained across Gemma 2 layers and sub-layers. Its central contribution is practical access: researchers can study model internals without first paying the cost of training a comprehensive SAE suite."
stats:
  - value: "2B · 9B · 27B"
    label: "Gemma 2 coverage"
  - value: "400+"
    label: "SAEs in the main release"
  - value: "30M+"
    label: "learned features"
  - value: "20 PiB"
    label: "activation storage"
source:
  label: "Gemma Scope · paper"
  url: "https://arxiv.org/abs/2408.05147"
related:
  - label: "Jumping Ahead · why JumpReLU"
    url: "https://arxiv.org/abs/2407.14435"
  - label: "Scaling Monosemanticity · scale and steering"
    url: "https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html"
  - label: "Geometry of Truth · raw-state baseline"
    url: "https://arxiv.org/abs/2310.06824"
  - label: "SAE Lens · loading tutorial"
    url: "https://decoderesearch.github.io/SAELens/latest/usage/"
---

This track teaches the original Gemma Scope release for Gemma 2. The pages
separate what the paper reports from what a small Colab experiment can verify.
