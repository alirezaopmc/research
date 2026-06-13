---
title: "Beyond Examples: High-level Automated Reasoning Paradigm in In-Context Learning via MCTS"
authors: "Jinyang Wu, Mingkuan Feng, Shuai Zhang, Feihu Che et al."
year: 2024
venue:
arxiv: 2411.18478
url: https://huggingface.co/papers/2411.18478
tags: [icl]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2411.18478
- **Hugging Face paper page:** https://huggingface.co/papers/2411.18478

## TL;DR

Uses MCTS to construct abstract reasoning patterns for ICL, then selects patterns at inference to guide problem solving beyond examples.

## Novelty

Novel shift from selecting examples to selecting reusable high-level reasoning actions/patterns.

## Compute Cost

Moderate: inference-time search plus Qwen2.5-7B experiments are feasible but nontrivial.

## Trend and Hype

High: reasoning-pattern libraries and test-time search are hot.

## Market Demand

Relevant to agent reasoning, math tutors, and prompt orchestration systems.

## Reproducibility

Partially reproducible on 1x RTX 4090 + Colab Pro: 7B-scale subsets are feasible; full benchmark reproduction may need time/API budget.

## Method

From the abstract: In-context learning (ICL) enables large language models (LLMs) to perform downstream tasks through advanced prompting and high-quality demonstrations. However, traditional ICL paradigms encounter significant limitations in complex reasoning tasks, stemming primarily from their dependence on example quality and absence of explicit reasoning guidance. To address these challenges, we introduce HiAR-ICL, a **Hi**gh-level **A**utomated **R**easoning paradigm in **ICL** that shifts focus from specific examples to...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
