---
title: 'Direct Preference Optimization: Your Language Model is Secretly a Reward Model'
authors: Rafael Rafailov et al.
year: 2023
venue: NeurIPS
arxiv: '2305.18290'
url: https://arxiv.org/abs/2305.18290
tags:
- preference-optimization
- rlhf
- post-training
- llm
paper_abstract: UNREAD
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
---

## Paper link

- **Paper:** https://arxiv.org/abs/2305.18290

## TL;DR

DPO optimizes language models directly from preference pairs, avoiding explicit reward-model training and PPO.

## Why it matters (hype / industry / cost)

- **Compute:** much more accessible than full PPO-based RLHF.
- **Hype / market:** widely used family of post-training methods.
- **Industry:** practical alignment, style tuning, policy tuning, agent behavior tuning.
- **Pillar fit:** key method for low-compute RL-adjacent LLM research.

## Method

DPO derives a supervised objective from the RLHF preference formulation, using chosen/rejected response pairs and a reference model.

## Results

DPO can match or outperform RLHF-style baselines on preference alignment while being simpler and more stable to train.

## Notes / quotes

- Read after [[papers/instructgpt-rlhf]].
- Strong candidate for small LoRA experiments on agent trajectory preferences.

## Open questions

- How should DPO be applied to multi-step agent trajectories?
- Should preferences compare final answers, full traces, or individual actions?