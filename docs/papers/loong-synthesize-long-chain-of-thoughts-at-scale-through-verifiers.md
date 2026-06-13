---
title: "Loong: Synthesize Long Chain-of-Thoughts at Scale through Verifiers"
authors: "Xingyue Huang, Rishabh, Gregor Franke, Ziyi Yang et al."
year: 2025
venue:
arxiv: 2509.03059
url: https://huggingface.co/papers/2509.03059
tags: [cot, reasoning]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2509.03059
- **Hugging Face paper page:** https://huggingface.co/papers/2509.03059

## TL;DR

Loong provides a seed benchmark and modular environment for generating/verifying long CoT data across many reasoning domains.

## Novelty

Novel open framework combining human-vetted seeds, executable verification, and agent-environment synthetic data generation.

## Compute Cost

High: broad generation, verification, and benchmarking across proprietary/open models is costly.

## Trend and Hype

High: long-CoT synthetic data and verifier loops are hot.

## Market Demand

Relevant to reasoning-data pipelines, educational AI, and domain benchmark creation.

## Reproducibility

**Not reproducible on 1x RTX 4090 + Colab Pro as a full project:** small LoongEnv runs are feasible; broad data generation/evaluation is not.

## Method

From the abstract: Recent advances in Large Language Models (LLMs) have shown that their reasoning capabilities can be significantly improved through Reinforcement Learning with Verifiable Reward (RLVR), particularly in domains like mathematics and programming, where ground-truth correctness can be automatically evaluated. However, extending this success to other reasoning-intensive domains remains challenging due to the scarcity of high-quality, verifiable datasets and the high cost of human supervision. In this work, we...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
