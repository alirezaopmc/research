---
title: "A Systematic Survey of Prompt Engineering in Large Language Models: Techniques and Applications"
authors: "Pranab Sahoo, Ayush Kumar Singh, Sriparna Saha, Vinija Jain et al."
year: 2024
venue:
arxiv: 2402.07927
url: https://huggingface.co/papers/2402.07927
tags: [prompting, survey]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2402.07927
- **Hugging Face paper page:** https://huggingface.co/papers/2402.07927

## TL;DR

Systematizes prompt-engineering techniques across LLM/VLM applications, summarizing methods, models, datasets, strengths, and limits.

## Novelty

Novel as a taxonomy and survey, not a new algorithm.

## Compute Cost

Low: literature-review cost only.

## Trend and Hype

High as background because prompt engineering is still a common entry point to LLM applications.

## Market Demand

Strong for practitioners building prompt, RAG, and agent workflows.

## Reproducibility

Reproducible on 1x RTX 4090 + Colab Pro: no compute reproduction needed beyond reading and small prompt trials.

## Method

From the abstract: Prompt engineering has emerged as an indispensable technique for extending the capabilities of large language models (LLMs) and vision-language models (VLMs). This approach leverages task-specific instructions, known as prompts, to enhance model efficacy without modifying the core model parameters. Rather than updating the model parameters, prompts allow seamless integration of pre-trained models into downstream tasks by eliciting desired model behaviors solely based on the given prompt. Prompts can be natural...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
