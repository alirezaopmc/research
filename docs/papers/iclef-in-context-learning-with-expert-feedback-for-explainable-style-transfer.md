---
title: "ICLEF: In-Context Learning with Expert Feedback for Explainable Style Transfer"
authors: "Arkadiy Saakyan, Smaranda Muresan"
year: 2023
venue:
arxiv: 2309.08583
url: https://arxiv.org/abs/2309.08583
tags: [icl]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2309.08583

## TL;DR

Combines scarce expert feedback, ICL, and model self-critique to distill explainable style-transfer datasets into smaller models.

## Novelty

Novel human-AI data-generation loop for explainable style transfer rather than plain style rewriting.

## Compute Cost

Moderate: dataset generation is API-heavy and student fine-tuning is feasible at small scale.

## Trend and Hype

Moderate: explainability and synthetic data remain relevant, but style transfer is less hyped than agents/reasoning.

## Market Demand

Useful for writing assistants, bias mitigation, and controllable rewriting tools.

## Reproducibility

Partially reproducible on 1x RTX 4090 + Colab Pro: student fine-tunes are feasible; expert-feedback replication is the bottleneck.

## Method

From the abstract: While state-of-the-art large language models (LLMs) can excel at adapting text from one style to another, current work does not address the explainability of style transfer models. Recent work has explored generating textual explanations from larger teacher models and distilling them into smaller student models. One challenge with such approach is that LLM outputs may contain errors that require expertise to correct, but gathering and incorporating expert feedback is difficult due to cost and availability. To...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
