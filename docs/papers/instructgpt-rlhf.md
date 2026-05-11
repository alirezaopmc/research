---
title: Training Language Models to Follow Instructions with Human Feedback
authors: Long Ouyang et al.
year: 2022
venue: NeurIPS
arxiv: '2203.02155'
url: https://arxiv.org/abs/2203.02155
tags:
- rlhf
- post-training
- alignment
- llm
paper_abstract: UNREAD
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
---

## Paper link

- **Paper:** https://arxiv.org/abs/2203.02155

## TL;DR

OpenAI trains instruction-following LMs using supervised fine-tuning, reward modeling, and PPO-based RLHF, showing that smaller aligned models can be preferred over larger base models.

## Why it matters (hype / industry / cost)

- **Compute:** full reproduction is expensive, but the pipeline is essential to understand.
- **Hype / market:** RLHF is the foundation of modern assistant post-training.
- **Industry:** instruction following, safety behavior, and preference learning are core product capabilities.
- **Pillar fit:** central background for [[research/topics/rl-llm-agents]].

## Method

Pipeline:

1. collect human-written demonstrations;
2. supervised fine-tune a base LM;
3. collect human preference comparisons;
4. train a reward model;
5. optimize the policy with PPO against the reward model.

## Results

Human evaluators prefer the RLHF-trained models over much larger pretrained baselines on instruction-following tasks.

## Notes / quotes

- Read for the RLHF pipeline, not for direct low-compute reproduction.
- Compare later with [[papers/direct-preference-optimization]].

## Open questions

- Which parts of this pipeline can be made cheap enough for small labs?
- For agents, should reward models score individual actions, full trajectories, or both?