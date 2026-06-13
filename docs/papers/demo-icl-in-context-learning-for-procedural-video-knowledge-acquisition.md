---
title: "Demo-ICL: In-Context Learning for Procedural Video Knowledge Acquisition"
authors: "Yuhao Dong, Shulin Tian, Shuai Liu, Shuangrui Ding et al."
year: 2026
venue:
arxiv: 2602.08439
url: https://arxiv.org/abs/2602.08439
tags: [icl, multimodal]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2602.08439

## TL;DR

Introduces demo-driven video ICL and a benchmark where multimodal models learn procedural video knowledge from text or video demonstrations.

## Novelty

Novel benchmark/task framing for in-context learning over dynamic procedural video examples.

## Compute Cost

High: video MLLM SFT and DPO plus 1200-video evaluation is expensive.

## Trend and Hype

High: multimodal agents and video understanding are very active.

## Market Demand

Strong in tutorials, robotics, support automation, and procedural knowledge systems.

## Reproducibility

**Not reproducible on 1x RTX 4090 + Colab Pro as a full study:** benchmark inspection and small inference tests are feasible; training Demo-ICL is not.

## Method

From the abstract: Despite the growing video understanding capabilities of recent Multimodal Large Language Models (MLLMs), existing video benchmarks primarily assess understanding based on models' static, internal knowledge, rather than their ability to learn and adapt from dynamic, novel contexts from few examples. To bridge this gap, we present Demo-driven Video In-Context Learning, a novel task focused on learning from in-context demonstrations to answer questions about the target videos. Alongside this, we propose...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
