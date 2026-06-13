---
title: "ICL Markup: Structuring In-Context Learning using Soft-Token Tags"
authors: "Marc-Etienne Brunet, Ashton Anderson, Richard Zemel"
year: 2023
venue:
arxiv: 2312.07405
url: https://arxiv.org/abs/2312.07405
tags: [icl]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2312.07405

## TL;DR

Learns soft-token markup tags that structure prompt templates and can transfer to unseen ICL tasks after a parameter-efficient warm-up.

## Novelty

Novel by treating prompt structure like learned markup instead of hand-written delimiters.

## Compute Cost

Moderate: requires parameter-efficient fine-tuning, but can be tried on small open LLMs.

## Trend and Hype

Moderate: prompt structure is practical, though soft-token methods compete with instruction tuning and long-context prompting.

## Market Demand

Useful for intent detection, classification, and enterprise prompt templates where consistent structure matters.

## Reproducibility

Partially reproducible on 1x RTX 4090 + Colab Pro with small PEFT experiments; broad enterprise benchmark coverage is not.

## Method

From the abstract: Large pretrained language models (LLMs) can be rapidly adapted to a wide variety of tasks via a text-to-text approach, where the instruction and input are fed to the model in natural language. Combined with in-context learning (ICL), this paradigm is impressively flexible and powerful. However, it also burdens users with an overwhelming number of choices, many of them arbitrary. Inspired by markup languages like HTML, we contribute a method of using soft-token tags to compose prompt templates. This approach...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
