---
title: "iCLP: Large Language Model Reasoning with Implicit Cognition Latent Planning"
authors: "Sijia Chen, Di Niu"
year: 2025
venue:
arxiv: 2512.24014
url: https://arxiv.org/abs/2512.24014
tags: [icl]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2512.24014

## TL;DR

Learns compact latent plans from explicit reasoning traces so LLMs can plan implicitly while still reasoning in language.

## Novelty

Novel coupling of plan distillation, vector-quantized latent codes, and LLM fine-tuning for reasoning.

## Compute Cost

High: requires collecting reasoning traces, training a VQ component, and fine-tuning LLMs.

## Trend and Hype

High: latent reasoning/planning is a major post-CoT direction.

## Market Demand

Relevant to reasoning models, code generation, and efficient agent planning.

## Reproducibility

**Not reproducible on 1x RTX 4090 + Colab Pro as a full paper:** toy latent-planning experiments are feasible, full LLM fine-tuning/generalization is not.

## Method

From the abstract: Large language models (LLMs), when guided by explicit textual plans, can perform reliable step-by-step reasoning during problem-solving. However, generating accurate and effective textual plans remains challenging due to LLM hallucinations and the high diversity of task-specific questions. To address this, we draw inspiration from human Implicit Cognition (IC), the subconscious process by which decisions are guided by compact, generalized patterns learned from past experiences without requiring explicit...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
