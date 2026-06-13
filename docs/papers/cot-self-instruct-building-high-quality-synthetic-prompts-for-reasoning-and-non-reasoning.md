---
title: "CoT-Self-Instruct: Building high-quality synthetic prompts for reasoning and non-reasoning tasks"
authors: "Ping Yu, Jack Lanchantin, Tianlu Wang, Weizhe Yuan et al."
year: 2025
venue:
arxiv: 2507.23751
url: https://huggingface.co/papers/2507.23751
tags: [cot, prompting]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2507.23751
- **Hugging Face paper page:** https://huggingface.co/papers/2507.23751

## TL;DR

Generates higher-quality synthetic prompts by first reasoning/planning with CoT from seed tasks, then filtering generated examples for training.

## Novelty

Novel extension of Self-Instruct where CoT planning guides both reasoning and non-reasoning data creation.

## Compute Cost

High for full training/evaluation; moderate for generating a small synthetic dataset.

## Trend and Hype

High: synthetic data for reasoning models is intensely hyped.

## Market Demand

Strong demand from teams building instruction data without human labeling.

## Reproducibility

**Not reproducible on 1x RTX 4090 + Colab Pro as a full paper:** small data-generation trials are feasible; full training and leaderboard evaluation are not.

## Method

From the abstract: We propose CoT-Self-Instruct, a synthetic data generation method that instructs LLMs to first reason and plan via Chain-of-Thought (CoT) based on given seed tasks, and then generate a new synthetic example of similar quality and complexity. This is followed by a filtering step to select high-quality data using automatic metrics, which are then used for LLM training. In verifiable reasoning, our synthetic data significantly outperforms existing training datasets, such as s1k and OpenMathReasoning, when evaluated...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
