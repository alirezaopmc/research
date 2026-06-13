---
title: "Landscape of Thoughts: Visualizing the Reasoning Process of Large Language Models"
authors: "Zhanke Zhou, Zhaocheng Zhu, Xuan Li, Mikhail Galkin et al."
year: 2025
venue:
arxiv: 2503.22165
url: https://huggingface.co/papers/2503.22165
tags: [reasoning]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2503.22165
- **Hugging Face paper page:** https://huggingface.co/papers/2503.22165

## TL;DR

Landscape of Thoughts visualizes reasoning trajectories by mapping textual states to answer-choice distance features and plotting them with t-SNE.

## Novelty

Novel visualization tool for comparing reasoning trajectories, model strength, and failure modes.

## Compute Cost

Low-to-moderate: mainly inference plus feature extraction/visualization.

## Trend and Hype

Moderate-to-high: interpretability for reasoning models is active.

## Market Demand

Useful for model debugging, eval dashboards, and safety analysis.

## Reproducibility

Reproducible on 1x RTX 4090 + Colab Pro for small datasets and open models; broad verifier gains need more runs.

## Method

From the abstract: Numerous applications of large language models (LLMs) rely on their ability to perform step-by-step reasoning. However, the reasoning behavior of LLMs remains poorly understood, posing challenges to research, development, and safety. To address this gap, we introduce landscape of thoughts (LoT), the first landscape visualization tool to inspect the reasoning trajectories with certain reasoning methods on any multi-choice dataset. We represent the textual states in a trajectory as numerical features that...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
