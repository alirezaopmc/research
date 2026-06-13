---
title: "Many-Shot CoT-ICL: Making In-Context Learning Truly Learn"
authors: "Tsz Ting Chung, Lemao Liu, Mo Yu, Dit-Yan Yeung"
year: 2026
venue:
arxiv: 2605.13511
url: https://huggingface.co/papers/2605.13511
tags: [icl, cot]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2605.13511
- **Hugging Face paper page:** https://huggingface.co/papers/2605.13511

## TL;DR

Studies many-shot CoT-ICL and finds reasoning demos need curriculum-like ordering rather than simple similarity retrieval.

## Novelty

Novel because it treats long-context CoT prompting as test-time learning with ordering effects.

## Compute Cost

Moderate-to-high: many-shot long-context inference can be expensive, especially with reasoning models.

## Trend and Hype

High: long-context and test-time learning are major trends.

## Market Demand

Useful for prompt pipelines, tutoring datasets, and enterprise reasoning workflows.

## Reproducibility

Partially reproducible on 1x RTX 4090 + Colab Pro with smaller contexts/models; full many-shot reasoning sweeps are costly.

## Method

From the abstract: In-context learning (ICL) adapts large language models (LLMs) to new tasks by conditioning on demonstrations in the prompt without parameter updates. With long-context models, many-shot ICL can use dozens to hundreds of examples and achieve performance comparable to fine-tuning, yet current understanding of its scaling behavior is largely derived from non-reasoning tasks. We study many-shot chain-of-thought in-context learning (CoT-ICL) for reasoning and show that standard many-shot rules do not transfer....

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
