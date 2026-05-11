---
title: 'ReAct: Synergizing Reasoning and Acting in Language Models'
authors: Shunyu Yao et al.
year: 2022
venue: arXiv
arxiv: '2210.03629'
url: https://arxiv.org/abs/2210.03629
tags:
- agents
- prompting
- tool-use
- reasoning
- llm
paper_abstract: UNREAD
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
---

## Paper link

- **Paper:** https://arxiv.org/abs/2210.03629

## TL;DR

ReAct prompts language models to interleave reasoning traces with actions, making tool-use agents more interpretable and effective without model training.

## Why it matters (hype / industry / cost)

- **Compute:** excellent low-compute baseline; mostly inference and prompting.
- **Hype / market:** core pattern behind many practical LLM agents.
- **Industry:** useful for search agents, code agents, support agents, and workflow automation.
- **Pillar fit:** foundation for [[research/topics/rl-llm-agents]] experiments.

## Method

The model alternates between thoughts, actions, and observations. This lets it reason about what to do next, call external tools, observe results, and continue.

## Results

ReAct improves performance and interpretability on question answering and decision-making tasks compared with reasoning-only or action-only prompting.

## Notes / quotes

- Treat as the first baseline for any agent experiment.
- Compare with [[papers/reflexion]] for feedback-driven improvement.

## Open questions

- Where does ReAct fail: bad reasoning, bad action choice, or bad observation use?
- Can failure feedback target specific trajectory steps instead of full episodes?