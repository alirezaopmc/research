---
title: "Beyond Chain-of-Thought, Effective Graph-of-Thought Reasoning in Language Models"
authors: "Yao Yao, Zuchao Li, Hai Zhao"
year: 2023
venue:
arxiv: 2305.16582
url: https://huggingface.co/papers/2305.16582
tags: [cot, reasoning]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2305.16582
- **Hugging Face paper page:** https://huggingface.co/papers/2305.16582

## TL;DR

Adds graph-structured thought representations with a GoT encoder and gated fusion for text and multimodal reasoning tasks.

## Novelty

Novel trainable graph representation layer over thought units, unlike purely prompt-only GoT frameworks.

## Compute Cost

Moderate: T5-base-style experiments are feasible, but multimodal ScienceQA training adds setup cost.

## Trend and Hype

Moderate: influential idea, though newer prompt/search graph methods are more visible.

## Market Demand

Useful for structured reasoning models and multimodal QA systems.

## Reproducibility

Partially reproducible on 1x RTX 4090 + Colab Pro: text experiments are feasible; full multimodal replication may be tight.

## Method

From the abstract: With the widespread use of language models (LMs) in NLP tasks, researchers have discovered the potential of Chain-of-thought (CoT) to assist LMs in accomplishing complex reasoning tasks by generating intermediate steps. However, human thought processes are often non-linear, rather than simply sequential chains of thoughts. Therefore, we propose Graph-of-Thought (GoT) reasoning, which models human thought processes not only as a chain but also as a graph. By representing thought units as nodes and connections...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
