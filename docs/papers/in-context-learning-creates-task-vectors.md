---
title: "In-Context Learning Creates Task Vectors"
authors: "Roee Hendel, Mor Geva, Amir Globerson"
year: 2023
venue:
arxiv: 2310.15916
url: https://arxiv.org/abs/2310.15916
tags: [icl]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2310.15916

## TL;DR

Argues that ICL compresses demonstrations into a task vector that modulates transformer behavior for the query.

## Novelty

Novel simplification of ICL mechanisms into a single learned task-vector abstraction.

## Compute Cost

Moderate: requires activation/representation experiments across tasks and models.

## Trend and Hype

High for ICL interpretability and mechanistic explanations.

## Market Demand

Useful for prompt compression, adapters, and controllable task representations.

## Reproducibility

Partially reproducible on 1x RTX 4090 + Colab Pro with smaller open models; comprehensive model/task sweeps are expensive.

## Method

From the abstract: In-context learning (ICL) in Large Language Models (LLMs) has emerged as a powerful new learning paradigm. However, its underlying mechanism is still not well understood. In particular, it is challenging to map it to the "standard" machine learning framework, where one uses a training set $S$ to find a best-fitting function $f(x)$ in some hypothesis class. Here we make progress on this problem by showing that the functions learned by ICL often have a very simple structure: they correspond to the transformer LLM...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
