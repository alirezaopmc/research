---
title: 'WebGPT: Browser-assisted Question-Answering with Human Feedback'
authors: Reiichiro Nakano et al.
year: 2021
venue: arXiv
arxiv: '2112.09332'
url: https://arxiv.org/abs/2112.09332
tags:
- rlhf
- agents
- web
- tool-use
- llm
paper_abstract: UNREAD
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
---

## Paper link

- **Paper:** https://arxiv.org/abs/2112.09332

## TL;DR

WebGPT trains a language model to browse the web and answer questions using demonstrations, reward modeling, and RLHF.

## Why it matters (hype / industry / cost)

- **Compute:** full training is high-cost, but the environment and evaluation ideas are reusable.
- **Hype / market:** early blueprint for web agents and browsing assistants.
- **Industry:** browser agents, research assistants, citation-grounded QA.
- **Pillar fit:** direct fit for [[research/topics/rl-llm-agents]].

## Method

The model interacts with a text browser, chooses search/click/quote actions, and produces cited answers. Human comparisons train a reward model; RL optimizes answer quality against that reward.

## Results

The system improves answer quality and citation behavior compared with non-browsing baselines, though reliability still depends on search, source quality, and reward design.

## Notes / quotes

- Important bridge between RLHF and tool-using agents.
- Read before designing web or retrieval-agent projects.

## Open questions

- Can small agents learn browsing behavior from logged traces instead of online RL?
- How should rewards penalize unsupported claims and bad citations?