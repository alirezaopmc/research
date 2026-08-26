---
title: "A Survey on Sparse Autoencoders"
authors: "Gao et al."
year: 2025
venue: arXiv
arxiv: "2503.05613"
url: "https://arxiv.org/abs/2503.05613v3"
tags: ["sae", "survey", "interpretability", "dictionary-learning"]
topic: "Comprehensive review of Sparse Autoencoder architectures and applications"
paper_abstract: UNREAD
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: true
paper_to_read: true
---

## Paper link

- **Paper:** [arXiv:2503.05613v3](https://arxiv.org/abs/2503.05613v3)

## TL;DR

Comprehensive survey of Sparse Autoencoder (SAE) architectures (Vanilla, TopK, JumpReLU, Gated, BatchTopK), training objectives, evaluation metrics, and open challenges.

## Why it matters (hype / industry / cost)

- **Compute:** Reference handbook—no experimental cost to consult.
- **Hype / market:** Up-to-date systematization of the rapidly evolving SAE landscape.
- **Industry:** Outlines downstream applications in safety, monitoring, and debugging.
- **Topic fit:** Informs methodology section and architectural choices for SAE feature analysis.

## Method

- Categorizes SAE loss formulations (L1 penalty vs TopK/JumpReLU activation functions).
- Evaluates metrics: L0 (sparsity), reconstruction fidelity (CE loss recovery / MSE), and feature monosemanticity.

## Results

- Systematic comparison of tradeoffs between sparsity, reconstruction accuracy, and computational overhead.

## Notes / quotes

- Relates to [[notes/research-strategy]].

## Open questions

- Which SAE architecture exhibits the highest feature stability for factuality classification?
