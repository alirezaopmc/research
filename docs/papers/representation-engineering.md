---
title: "Representation Engineering: A Top-Down Approach to AI Transparency"
authors: "Zou et al. (Center for AI Safety)"
year: 2023
venue: arXiv
arxiv: "2310.01405"
url: "https://arxiv.org/abs/2310.01405"
tags: ["representation-engineering", "repe", "steering", "honesty", "hallucination"]
topic: "Top-down reading and control vectors for model honesty"
paper_abstract: UNREAD
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: true
paper_to_read: true
---

## Paper link

- **Paper:** [arXiv:2310.01405](https://arxiv.org/abs/2310.01405)
- **Code:** [GitHub - Representation Engineering](https://github.com/andyzoujm/representation-engineering)

## TL;DR

Introduces Representation Engineering (RepE): reading high-level cognitive states (honesty, morality, emotion) via contrastive activations and steering generation via vector addition.

## Why it matters (hype / industry / cost)

- **Compute:** Extremely fast inference-time vector addition; easily runs on Colab / 1x GPU.
- **Hype / market:** Highly influential framework for white-box model steering and transparency.
- **Industry:** Production-viable runtime guardrails without re-training or fine-tuning weights.
- **Topic fit:** Baseline and reference architecture for RQ3 (mitigation/steering vs. abstention).

## Method

- Construct contrastive pairs (honest vs. dishonest prompts).
- Compute reading vectors using PCA on differential activations.
- Apply control vectors at target layers during forward passes.

## Results

- Substantially improved honesty and reduced hallucination rates across open LLMs (Llama 2).

## Notes / quotes

- Core reference in [[notes/research-strategy]].

## Open questions

- How does coarse linear vector addition (RepE) compare with fine-grained SAE feature clamping in terms of side-effects on general capability?
