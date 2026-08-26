---
title: "Scaling Monosemanticity: Extracting Interpretable Features from Claude 3 Sonnet"
authors: "Templeton et al. (Anthropic)"
year: 2024
venue: Anthropic Research
arxiv: ""
url: "https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html"
tags: ["sae", "interpretability", "monosemanticity", "steering"]
topic: "High-level feature extraction & steering in frontier models"
paper_abstract: UNREAD
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: true
paper_to_read: true
---

## Paper link

- **Paper:** [Anthropic Transformer Circuits](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html)

## TL;DR

Demonstrates scaling TopK / dictionary learning to extract millions of interpretable, safety- and concept-relevant monosemantic features from a frontier LLM (Claude 3 Sonnet).

## Why it matters (hype / industry / cost)

- **Compute:** Proves concept at scale; provides reference methodology for feature interpretation and feature clamping.
- **Hype / market:** Milestone Anthropic publication establishing SAEs for alignment and steering.
- **Industry:** Foundations for runtime safety and model introspection.
- **Topic fit:** Validates that complex abstract concepts (including deception, errors, confidence) exist as isolated sparse features.

## Method

- TopK SAE architecture to eliminate L1 penalty tuning and shrinkage.
- Feature steering via activation clamping: artificially increasing or suppressing specific feature activations.

## Results

- Found high-level abstract features (cities, security vulnerabilities, bias, deception).
- Demonstrated controllable behavioral steering by modifying feature activations.

## Notes / quotes

- Relates to [[papers/gemma-scope]] and [[notes/research-strategy]].

## Open questions

- Can feature clamping be used selectively at inference time to suppress hallucination without degrading reasoning?
