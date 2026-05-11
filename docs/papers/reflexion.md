---
title: 'Reflexion: Language Agents with Verbal Reinforcement Learning'
authors: Noah Shinn et al.
year: 2023
venue: NeurIPS
arxiv: '2303.11366'
url: https://arxiv.org/abs/2303.11366
tags:
- agents
- reinforcement-learning
- feedback
- memory
- llm
paper_abstract: UNREAD
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
---

## Paper link

- **Paper:** https://arxiv.org/abs/2303.11366

## TL;DR

Reflexion improves LLM agents by storing natural-language reflections after failures, giving a lightweight alternative to weight updates.

## Why it matters (hype / industry / cost)

- **Compute:** very suitable for limited compute; no training required.
- **Hype / market:** self-improving agents are highly active.
- **Industry:** error recovery, workflow agents, coding agents, task automation.
- **Pillar fit:** one of the best starting points for [[research/topics/rl-llm-agents]].

## Method

After each episode, the agent receives feedback, generates a verbal reflection, stores it in memory, and conditions future attempts on that memory.

## Results

The method improves performance on several agent tasks by using feedback across trials without gradient-based RL.

## Notes / quotes

- This is the most practical first reproduction target.
- Good pair with [[papers/react]] for a low-compute baseline comparison.

## Open questions

- Which feedback is useful: scalar reward, critique, failure label, or step-level diagnosis?
- When does reflection memory become noisy or harmful?