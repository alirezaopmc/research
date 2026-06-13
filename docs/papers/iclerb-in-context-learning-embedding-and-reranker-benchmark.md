---
title: "ICLERB: In-Context Learning Embedding and Reranker Benchmark"
authors: "Marie Al Ghossein, Emile Contal, Alexandre Robicquet"
year: 2024
venue:
arxiv: 2411.18947
url: https://arxiv.org/abs/2411.18947
tags: [icl, benchmark]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2411.18947

## TL;DR

Reframes retrieval for ICL as a recommendation problem and benchmarks retrievers by downstream ICL utility, not just semantic relevance.

## Novelty

Novel because ICLERB evaluates retrievers by task gain and adds RL ranking from AI feedback.

## Compute Cost

Moderate-to-high: benchmark evaluation and retriever fine-tuning require many LLM calls but small-model variants are possible.

## Trend and Hype

High: RAG and reranking remain hot, and utility-based retrieval is directly product-relevant.

## Market Demand

Strong demand in RAG systems where retrieval quality should optimize answer accuracy, not embedding similarity alone.

## Reproducibility

Partially reproducible on 1x RTX 4090 + Colab Pro: subset benchmark runs are feasible; full RLRAIF/LLM-call sweeps are costly.

## Method

From the abstract: In-Context Learning (ICL) enables Large Language Models (LLMs) to perform new tasks by conditioning on prompts with relevant information. Retrieval-Augmented Generation (RAG) enhances ICL by incorporating retrieved documents into the LLM's context at query time. However, traditional retrieval methods focus on semantic relevance, treating retrieval as a search problem. In this paper, we propose reframing retrieval for ICL as a recommendation problem, aiming to select documents that maximize utility in ICL tasks....

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
