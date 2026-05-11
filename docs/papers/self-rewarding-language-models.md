---
title: Self-Rewarding Language Models
authors: Dan Iter et al.
year: 2024
venue: arXiv
arxiv: '2401.10020'
url: https://arxiv.org/abs/2401.10020
tags:
- self-improvement
- rewards
- preference-optimization
- llm
paper_abstract: UNREAD
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
---

## Paper link

- **Paper:** https://arxiv.org/abs/2401.10020

## TL;DR

Self-Rewarding Language Models study whether models can improve by generating and judging their own instruction-following data.

## Why it matters (hype / industry / cost)

- **Compute:** moderate if scaled down; useful conceptually for synthetic feedback.
- **Hype / market:** self-improvement and scalable feedback are major agent themes.
- **Industry:** reducing human labeling costs for model and agent improvement.
- **Pillar fit:** relevant to low-cost feedback loops in [[research/topics/rl-llm-agents]].

## Method

The model generates responses, judges them, creates preference data, and improves through iterative training.

## Results

The paper reports gains from iterative self-rewarding, but the setup raises important questions about reward reliability and self-confirming errors.

## Notes / quotes

- Read critically: self-generated reward can amplify biases or blind spots.
- Useful for thinking about agent feedback without expensive labels.

## Open questions

- Can an agent reliably judge its own failed trajectories?
- When do self-rewards correlate with real task success?