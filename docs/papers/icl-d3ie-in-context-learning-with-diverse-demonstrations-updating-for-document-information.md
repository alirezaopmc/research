---
title: "ICL-D3IE: In-Context Learning with Diverse Demonstrations Updating for Document Information Extraction"
authors: "Jiabang He, Lei Wang, Yi Hu, Ning Liu et al."
year: 2023
venue:
arxiv: 2303.05063
url: https://arxiv.org/abs/2303.05063
tags: [icl]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2303.05063

## TL;DR

Adapts LLM in-context learning to document information extraction using hard, relationship, formatting, and iteratively updated demonstrations.

## Novelty

Novel early attempt to bridge the modality/task gap between document IE and text-only ICL prompting.

## Compute Cost

Low-to-moderate if using APIs or OCR-ready datasets; full historical Davinci/ChatGPT parity may need paid APIs.

## Trend and Hype

Moderate: document extraction remains commercially important, though newer multimodal models reduce novelty.

## Market Demand

High in enterprise document processing, forms, invoices, legal and compliance extraction.

## Reproducibility

Partially reproducible on 1x RTX 4090 + Colab Pro: prompt-based subsets are feasible; exact API-era baselines may not be.

## Method

From the abstract: Large language models (LLMs), such as GPT-3 and ChatGPT, have demonstrated remarkable results in various natural language processing (NLP) tasks with in-context learning, which involves inference based on a few demonstration examples. Despite their successes in NLP tasks, no investigation has been conducted to assess the ability of LLMs to perform document information extraction (DIE) using in-context learning. Applying LLMs to DIE poses two challenges: the modality and task gap. To this end, we propose a...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
