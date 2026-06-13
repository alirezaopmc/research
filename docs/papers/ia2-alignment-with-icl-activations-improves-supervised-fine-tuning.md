---
title: "IA2: Alignment with ICL Activations Improves Supervised Fine-Tuning"
authors: "Aayush Mishra, Daniel Khashabi, Anqi Liu"
year: 2025
venue:
arxiv: 2509.22621
url: https://arxiv.org/abs/2509.22621
tags: [icl]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2509.22621

## TL;DR

Uses ICL activation patterns as a self-distillation target before SFT, improving accuracy and calibration in data-scarce settings.

## Novelty

Novel because it aligns supervised fine-tuning internals to ICL behavior instead of only matching output tokens.

## Compute Cost

Moderate-to-high: requires activation capture and SFT across model families; small-scale replication is possible, full benchmark sweep is expensive.

## Trend and Hype

High within ICL/SFT alignment because it connects inference-time adaptation with cheaper deployed fine-tunes.

## Market Demand

Relevant to enterprise tuning where teams want ICL-like robustness without long prompts at inference.

## Reproducibility

Partially reproducible on 1x RTX 4090 + Colab Pro: small open models and a subset of benchmarks are feasible; full multi-model results are not.

## Method

From the abstract: Supervised Fine-Tuning (SFT) is used to specialize model behavior by training weights to produce intended target responses for queries. In contrast, In-Context Learning (ICL) adapts models during inference with instructions or demonstrations in the prompt. ICL can offer better generalizability and more calibrated responses compared to SFT in data scarce settings, at the cost of more inference compute. In this work, we ask the question: Can ICL's internal computations be used to improve the qualities of SFT? We...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
