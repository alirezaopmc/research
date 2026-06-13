---
title: "Scalable Chain of Thoughts via Elastic Reasoning"
authors: "Yuhui Xu, Hanze Dong, Lei Wang, Doyen Sahoo et al."
year: 2025
venue:
arxiv: 2505.05315
url: https://huggingface.co/papers/2505.05315
tags: [reasoning]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2505.05315
- **Hugging Face paper page:** https://huggingface.co/papers/2505.05315

## TL;DR

Elastic Reasoning separates thinking and solution budgets and trains models to remain reliable when reasoning is truncated.

## Novelty

Novel GRPO-integrated budget-constrained rollout strategy for robust reasoning under token limits.

## Compute Cost

High: reinforcement learning for reasoning models is expensive, though inference tests are feasible.

## Trend and Hype

High: token-budgeted reasoning is directly tied to deployment costs.

## Market Demand

Strong demand for latency/cost-controlled reasoning in production.

## Reproducibility

**Not reproducible on 1x RTX 4090 + Colab Pro as a full study:** small inference ablations are feasible; GRPO training is not.

## Method

From the abstract: Large reasoning models (LRMs) have achieved remarkable progress on complex tasks by generating extended chains of thought (CoT). However, their uncontrolled output lengths pose significant challenges for real-world deployment, where inference-time budgets on tokens, latency, or compute are strictly constrained. We propose Elastic Reasoning, a novel framework for scalable chain of thoughts that explicitly separates reasoning into two phases--thinking and solution--with independently allocated budgets. At test...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
