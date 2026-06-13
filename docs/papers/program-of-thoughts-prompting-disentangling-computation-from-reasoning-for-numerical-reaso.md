---
title: "Program of Thoughts Prompting: Disentangling Computation from Reasoning for Numerical Reasoning Tasks"
authors: "Wenhu Chen, Xueguang Ma, Xinyi Wang, William W. Cohen"
year: 2022
venue:
arxiv: 2211.12588
url: https://huggingface.co/papers/2211.12588
tags: [reasoning, prompting]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2211.12588
- **Hugging Face paper page:** https://huggingface.co/papers/2211.12588

## TL;DR

Program of Thoughts has the LLM write executable programs for numerical reasoning, delegating exact computation to an interpreter.

## Novelty

Novel early separation of reasoning generation from deterministic computation.

## Compute Cost

Low-to-moderate: prompt-based plus code execution; historical Codex baselines may need replacement.

## Trend and Hype

High lasting influence for tool use and code-assisted reasoning.

## Market Demand

Strong relevance to finance QA, math tutors, and tool-using agents.

## Reproducibility

Reproducible on 1x RTX 4090 + Colab Pro with open/code models or APIs; exact Codex results may not be.

## Method

From the abstract: Recently, there has been significant progress in teaching language models to perform step-by-step reasoning to solve complex numerical reasoning tasks. Chain-of-thoughts prompting (CoT) is by far the state-of-art method for these tasks. CoT uses language models to perform both reasoning and computation in the multi-step `thought' process. To disentangle computation from reasoning, we propose `Program of Thoughts' (PoT), which uses language models (mainly Codex) to express the reasoning process as a program. The...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
