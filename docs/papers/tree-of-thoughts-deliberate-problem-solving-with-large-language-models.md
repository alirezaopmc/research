---
title: "Tree of Thoughts: Deliberate Problem Solving with Large Language Models"
authors: "Shunyu Yao, Dian Yu, Jeffrey Zhao, Izhak Shafran et al."
year: 2023
venue:
arxiv: 2305.10601
url: https://huggingface.co/papers/2305.10601
tags: [reasoning]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2305.10601
- **Hugging Face paper page:** https://huggingface.co/papers/2305.10601

## TL;DR

Tree of Thoughts generalizes CoT into search over multiple coherent reasoning paths with self-evaluation and backtracking.

## Novelty

Novel inference-time search framework over thoughts rather than left-to-right single-chain decoding.

## Compute Cost

Low-to-moderate: prompt/search experiments are feasible, but GPT-4-level comparisons need API budget.

## Trend and Hype

Very high historical influence for agentic reasoning and test-time search.

## Market Demand

Strong in planning-heavy agents, puzzle solving, and automated task decomposition.

## Reproducibility

Reproducible on 1x RTX 4090 + Colab Pro using open models or APIs; exact GPT-4 numbers require paid access.

## Method

From the abstract: Language models are increasingly being deployed for general problem solving across a wide range of tasks, but are still confined to token-level, left-to-right decision-making processes during inference. This means they can fall short in tasks that require exploration, strategic lookahead, or where initial decisions play a pivotal role. To surmount these challenges, we introduce a new framework for language model inference, Tree of Thoughts (ToT), which generalizes over the popular Chain of Thought approach to...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
