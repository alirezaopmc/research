---
title: "Gemma Scope: Open Sparse Autoencoders Everywhere All At Once on Gemma 2"
authors: "Lieberum et al. (Google DeepMind)"
year: 2024
venue: arXiv
arxiv: "2408.05147"
url: "https://arxiv.org/abs/2408.05147"
tags: ["sae", "interpretability", "gemma", "tooling"]
topic: "Pretrained Sparse Autoencoders on Gemma 2"
paper_abstract: UNREAD
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: true
paper_to_read: true
---

## Paper link

- **Paper:** [arXiv:2408.05147](https://arxiv.org/abs/2408.05147)
- **Demo / Explorer:** [Neuronpedia Gemma Scope](https://www.neuronpedia.org/gemma-scope)

## TL;DR

Open suite of JumpReLU Sparse Autoencoders trained across all layers, sub-layers (MLP, attention, residual stream) of Gemma 2 (2B, 9B, 27B).

## Why it matters (hype / industry / cost)

- **Compute:** Crucial for zero-compute SAE extraction. Eliminates the need to train custom SAEs; run inference with `sae-lens` on Colab T4.
- **Hype / market:** Google DeepMind's flagship open interpretability release for Gemma 2.
- **Industry:** Standardizes SAE evaluation and open-weight model analysis.
- **Topic fit:** Primary dictionary source for our thesis experiments on Gemma 2.

## Method

- Architecture: JumpReLU SAEs across residual streams, attention outputs, and MLP activations.
- Models covered: Gemma 2 2B, 9B, and 27B across multiple expansion factors (16k, 32k, 65k, 131k features).

## Results

- Monosemantic feature extraction across multiple abstraction levels.

## Notes / quotes

- Connects to [[notes/research-strategy]].

## Open questions

- Which specific layers (early vs. mid vs. late MLP/residual) contain the clearest factual confidence/knowledge boundaries?
