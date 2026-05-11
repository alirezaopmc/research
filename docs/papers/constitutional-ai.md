---
title: 'Constitutional AI: Harmlessness from AI Feedback'
authors: Yuntao Bai et al.
year: 2022
venue: arXiv
arxiv: '2212.08073'
url: https://arxiv.org/abs/2212.08073
tags:
- rlhf
- rlaif
- alignment
- feedback
- llm
paper_abstract: UNREAD
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
---

## Paper link

- **Paper:** https://arxiv.org/abs/2212.08073

## TL;DR

Constitutional AI uses model-generated critiques and preference feedback guided by written principles, reducing dependence on human labels.

## Why it matters (hype / industry / cost)

- **Compute:** full training is expensive, but the feedback-generation idea is low-cost to explore.
- **Hype / market:** RLAIF and scalable oversight are central alignment themes.
- **Industry:** policy-following agents, safety rules, enterprise constraints.
- **Pillar fit:** useful for feedback design in [[research/topics/rl-llm-agents]].

## Method

The system critiques and revises model outputs using a constitution, then trains from AI-generated preference data using RL-style post-training.

## Results

AI feedback can improve harmlessness and helpfulness tradeoffs while reducing human-label demand.

## Notes / quotes

- Important for agent policies: what rules should agents follow during tool use?
- Pair with [[papers/self-rewarding-language-models]].

## Open questions

- Can constitutions guide tool-use agents without making them too cautious?
- How should rule violations be detected in long trajectories?