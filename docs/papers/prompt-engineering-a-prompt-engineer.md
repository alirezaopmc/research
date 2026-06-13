---
title: "Prompt Engineering a Prompt Engineer"
authors: "Qinyuan Ye, Maxamed Axmed, Reid Pryzant, Fereshte Khani"
year: 2023
venue:
arxiv: 2311.05661
url: https://huggingface.co/papers/2311.05661
tags: [prompting]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2311.05661
- **Hugging Face paper page:** https://huggingface.co/papers/2311.05661

## TL;DR

PE2 improves automatic prompt engineering by giving the meta-prompt descriptions, context, and a step-by-step prompt-editing template.

## Novelty

Novel practical meta-prompt recipe for making LLMs act as stronger prompt engineers.

## Compute Cost

Low: mostly inference calls on benchmark tasks.

## Trend and Hype

High: prompt optimization remains marketable and cheap to test.

## Market Demand

Strong demand for no-training prompt improvement in enterprise workflows.

## Reproducibility

Reproducible on 1x RTX 4090 + Colab Pro or APIs; cost scales with benchmark size.

## Method

From the abstract: Prompt engineering is a challenging yet crucial task for optimizing the performance of large language models on customized tasks. It requires complex reasoning to examine the model's errors, hypothesize what is missing or misleading in the current prompt, and communicate the task with clarity. While recent works indicate that large language models can be meta-prompted to perform automatic prompt engineering, we argue that their potential is limited due to insufficient guidance for complex reasoning in the...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
