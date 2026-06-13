---
title: "CoT-Valve: Length-Compressible Chain-of-Thought Tuning"
authors: "Xinyin Ma, Guangnian Wan, Runpeng Yu, Gongfan Fang et al."
year: 2025
venue:
arxiv: 2502.09601
url: https://huggingface.co/papers/2502.09601
tags: [cot, reasoning]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2502.09601
- **Hugging Face paper page:** https://huggingface.co/papers/2502.09601

## TL;DR

CoT-Valve learns to control and compress reasoning-chain length dynamically so one model can trade reasoning cost for task difficulty.

## Novelty

Novel parameter-space direction and tuning strategy for elastic CoT length control.

## Compute Cost

High: reported on QwQ-32B-Preview and chain-length datasets; full tuning is beyond a single 4090.

## Trend and Hype

High: reducing reasoning-token cost is commercially important.

## Market Demand

Strong relevance to inference-cost control for reasoning products.

## Reproducibility

**Not reproducible on 1x RTX 4090 + Colab Pro as a full study:** small-model demonstrations may be possible; 32B tuning is not.

## Method

From the abstract: Chain-of-Thought significantly enhances a model's reasoning capability, but it also comes with a considerable increase in inference costs due to long chains. With the observation that the reasoning path can be easily compressed under easy tasks but struggle on hard tasks, we explore the feasibility of elastically controlling the length of reasoning paths with only one model, thereby reducing the inference overhead of reasoning models dynamically based on task difficulty. We introduce a new tuning and inference...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
