---
title: "Chain-of-Thought Tokens are Computer Program Variables"
authors: "Fangwei Zhu, Peiyi Wang, Zhifang Sui"
year: 2025
venue:
arxiv: 2505.04955
url: https://huggingface.co/papers/2505.04955
tags: [cot, reasoning]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2505.04955
- **Hugging Face paper page:** https://huggingface.co/papers/2505.04955

## TL;DR

Shows CoT tokens often behave like program variables that store intermediate results, and interventions on them change downstream reasoning.

## Novelty

Novel mechanistic analogy between CoT tokens and mutable variables in compositional algorithms.

## Compute Cost

Moderate: controlled tasks and intervention experiments on open models are feasible.

## Trend and Hype

High for interpretability of reasoning; moderate product relevance.

## Market Demand

Useful for reasoning debugging, verifier design, and prompt compression research.

## Reproducibility

Reproducible on 1x RTX 4090 + Colab Pro for smaller open models and toy tasks; large-model coverage may need APIs.

## Method

From the abstract: Chain-of-thoughts (CoT) requires large language models (LLMs) to generate intermediate steps before reaching the final answer, and has been proven effective to help LLMs solve complex reasoning tasks. However, the inner mechanism of CoT still remains largely unclear. In this paper, we empirically study the role of CoT tokens in LLMs on two compositional tasks: multi-digit multiplication and dynamic programming. While CoT is essential for solving these problems, we find that preserving only tokens that store...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
