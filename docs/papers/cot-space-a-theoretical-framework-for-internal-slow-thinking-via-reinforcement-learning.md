---
title: "CoT-Space: A Theoretical Framework for Internal Slow-Thinking via Reinforcement Learning"
authors: "Zeyu Gan, Hao Yi, Yong Liu"
year: 2025
venue:
arxiv: 2509.04027
url: https://huggingface.co/papers/2509.04027
tags: [cot]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2509.04027
- **Hugging Face paper page:** https://huggingface.co/papers/2509.04027

## TL;DR

CoT-Space frames reasoning RL as optimization in a continuous reasoning-level semantic space, explaining overthinking and optimal CoT length.

## Novelty

Novel theoretical bridge between token-level RL and reasoning-level CoT dynamics.

## Compute Cost

Moderate: theory plus empirical validation; full RL experiments may be heavy.

## Trend and Hype

High among reasoning-RL researchers.

## Market Demand

Useful for reasoning-agent training and inference-budget policy design.

## Reproducibility

Partially reproducible on 1x RTX 4090 + Colab Pro for small empirical checks; full RL validation may not be.

## Method

From the abstract: Reinforcement Learning (RL) has become a pivotal approach for enhancing the reasoning capabilities of Large Language Models (LLMs). However, a significant theoretical gap persists, as traditional token-level RL frameworks fail to align with the reasoning-level nature of complex, multi-step thought processes like Chain-of-Thought (CoT). To address this challenge, we introduce CoT-Space, a novel theoretical framework that recasts LLM reasoning from a discrete token-prediction task to an optimization process...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
