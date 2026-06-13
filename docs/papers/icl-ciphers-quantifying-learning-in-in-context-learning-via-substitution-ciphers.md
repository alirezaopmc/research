---
title: "ICL CIPHERS: Quantifying \"Learning\" in In-Context Learning via Substitution Ciphers"
authors: "Zhouxiang Fang, Aayush Mishra, Muhan Gao, Anqi Liu et al."
year: 2025
venue:
arxiv: 2504.19395
url: https://arxiv.org/abs/2504.19395
tags: [icl]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2504.19395

## TL;DR

Substitution ciphers isolate task learning from task retrieval in ICL by forcing models to infer a reversible latent mapping from context.

## Novelty

Novel diagnostic: ciphered tasks make pretraining retrieval less useful while preserving an abstract solvable task.

## Compute Cost

Low-to-moderate: mostly inference and representation analysis across several LLMs.

## Trend and Hype

Strong for mechanistic ICL discussions; less product-facing but useful for evaluation design.

## Market Demand

Useful for labs building ICL diagnostics, prompt robustness tests, or model-behavior audits.

## Reproducibility

Reproducible on 1x RTX 4090 + Colab Pro for smaller/open models; proprietary-model comparisons require API budget.

## Method

From the abstract: Recent works have suggested that In-Context Learning (ICL) operates in dual modes, i.e. task retrieval (remember learned patterns from pre-training) and task learning (inference-time ''learning'' from demonstrations). However, disentangling these the two modes remains a challenging goal. We introduce ICL CIPHERS, a class of task reformulations based on substitution ciphers borrowed from classic cryptography. In this approach, a subset of tokens in the in-context inputs are substituted with other (irrelevant)...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
