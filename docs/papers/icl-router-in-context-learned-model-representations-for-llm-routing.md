---
title: "ICL-Router: In-Context Learned Model Representations for LLM Routing"
authors: "Chenxu Wang, Hao Li, Yiqun Zhang, Linyao Chen et al."
year: 2025
venue:
arxiv: 2510.09719
url: https://arxiv.org/abs/2510.09719
tags: [icl, routing]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2510.09719

## TL;DR

Routes queries to the best LLM by representing candidate model capabilities as in-context vectors, allowing new models to be added without retraining the router.

## Novelty

Novel because model representations are learned in-context rather than fixed by a retrained router for every model pool change.

## Compute Cost

Moderate: needs profiling multiple models and training a projector/router; small pools are feasible.

## Trend and Hype

High: LLM routing is market-relevant for cost/latency optimization.

## Market Demand

Strong demand from inference platforms, agent stacks, and enterprise model gateways.

## Reproducibility

Partially reproducible on 1x RTX 4090 + Colab Pro: small model pools and public benchmarks are feasible; large pool evaluation is not.

## Method

From the abstract: Large language models (LLMs) often exhibit complementary strengths. Model routing harnesses these strengths by dynamically directing each query to the most suitable model, given a candidate model pool. However, routing performance relies on accurate model representations, and adding new models typically requires retraining, limiting scalability. To address these challenges, we propose a novel routing method using in-context vectors to represent model capabilities. The method proceeds in two stages. First,...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
