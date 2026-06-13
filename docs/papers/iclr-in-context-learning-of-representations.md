---
title: "ICLR: In-Context Learning of Representations"
authors: "Core Francisco Park, Andrew Lee, Ekdeep Singh Lubana, Yongyi Yang et al."
year: 2024
venue:
arxiv: 2501.00070
url: https://arxiv.org/abs/2501.00070
tags: [icl]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2501.00070

## TL;DR

Shows that ICL can reorganize internal representations away from pretraining semantics toward context-specified graph semantics as context scales.

## Novelty

Novel mechanistic probe linking ICL representation shifts to conceptual-role semantics and implicit optimization.

## Compute Cost

Moderate: mostly controlled tasks and representation analysis; feasible on small/medium open models.

## Trend and Hype

High in interpretability circles; indirect product relevance.

## Market Demand

Useful for model analysis, safety, and context-engineering research.

## Reproducibility

Reproducible on 1x RTX 4090 + Colab Pro for smaller open models and toy graph tasks; large-model sweeps may need API budget.

## Method

From the abstract: Recent work has demonstrated that semantics specified by pretraining data influence how representations of different concepts are organized in a large language model (LLM). However, given the open-ended nature of LLMs, e.g., their ability to in-context learn, we can ask whether models alter these pretraining semantics to adopt alternative, context-specified ones. Specifically, if we provide in-context exemplars wherein a concept plays a different role than what the pretraining data suggests, do models...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
