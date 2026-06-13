---
title: "In-Context Principle Learning from Mistakes"
authors: "Tianjun Zhang, Aman Madaan, Luyu Gao, Steven Zheng et al."
year: 2024
venue:
arxiv: 2402.05403
url: https://huggingface.co/papers/2402.05403
tags: [icl]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2402.05403
- **Hugging Face paper page:** https://huggingface.co/papers/2402.05403

## TL;DR

LEAP induces mistakes on few-shot examples, extracts task principles from those mistakes, then prompts with principles plus examples.

## Novelty

Novel because it learns explicit principles from errors without requiring more demonstrations.

## Compute Cost

Low-to-moderate: prompt-only but uses strong closed models in the paper.

## Trend and Hype

High: error-reflection prompting remains relevant for agents and reasoning.

## Market Demand

Useful for prompt optimization, QA systems, and low-data task adaptation.

## Reproducibility

Reproducible on 1x RTX 4090 + Colab Pro with API or open models; exact GPT-4/Claude numbers require paid APIs.

## Method

From the abstract: In-context learning (ICL, also known as few-shot prompting) has been the standard method of adapting LLMs to downstream tasks, by learning from a few input-output examples. Nonetheless, all ICL-based approaches only learn from correct input-output pairs. In this paper, we revisit this paradigm, by learning more from the few given input-output examples. We introduce Learning Principles (LEAP): First, we intentionally induce the model to make mistakes on these few examples; then we reflect on these mistakes, and...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
