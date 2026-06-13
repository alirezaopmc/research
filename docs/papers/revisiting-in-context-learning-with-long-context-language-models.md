---
title: "Revisiting In-Context Learning with Long Context Language Models"
authors: "Jinheon Baek, Sun Jae Lee, Prakhar Gupta, Geunseob Oh et al."
year: 2024
venue:
arxiv: 2412.16926
url: https://huggingface.co/papers/2412.16926
tags: [icl]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2412.16926
- **Hugging Face paper page:** https://huggingface.co/papers/2412.16926

## TL;DR

Revisits ICL under long-context LLMs and finds data quantity/augmentation can matter more than sophisticated example selection.

## Novelty

Novel update to classic ICL selection assumptions in the long-context regime.

## Compute Cost

Moderate: needs long-context inference over 18 datasets; subsets are feasible.

## Trend and Hype

High: long-context prompting is commercially important.

## Market Demand

Strong relevance for RAG, classification, and few-shot systems that can pack many examples.

## Reproducibility

Partially reproducible on 1x RTX 4090 + Colab Pro: subset experiments are feasible; full 18-dataset sweep needs larger inference budget.

## Method

From the abstract: In-Context Learning (ICL) is a technique by which language models make predictions based on examples provided in their input context. Previously, their context window size imposed a limit on the number of examples that can be shown, making example selection techniques crucial for identifying the maximally effective set of examples. However, the recent advent of Long Context Language Models (LCLMs) has significantly increased the number of examples that can be included in context, raising an important question...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
