---
title: 'Voyager: An Open-Ended Embodied Agent with Large Language Models'
authors: Guanzhi Wang et al.
year: 2023
venue: arXiv
arxiv: '2305.16291'
url: https://arxiv.org/abs/2305.16291
tags:
- agents
- lifelong-learning
- tool-use
- memory
- llm
paper_abstract: UNREAD
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
---

## Paper link

- **Paper:** https://arxiv.org/abs/2305.16291

## TL;DR

Voyager uses an LLM agent in Minecraft with automatic curriculum, skill discovery, and a reusable skill library for long-horizon exploration.

## Why it matters (hype / industry / cost)

- **Compute:** reproduction is more involved, but concepts transfer to smaller environments.
- **Hype / market:** long-horizon agents and skill libraries are central agent themes.
- **Industry:** reusable workflow skills, automation libraries, coding-agent memory.
- **Pillar fit:** relevant to long-term agent improvement in [[research/topics/rl-llm-agents]].

## Method

The agent proposes tasks, writes executable skills, stores successful skills, retrieves them later, and improves through iterative environment feedback.

## Results

Voyager explores more broadly and acquires more diverse skills than strong prompting baselines in Minecraft.

## Notes / quotes

- Read for memory, curriculum, and skill-library design.
- Not the first reproduction target unless a small environment is chosen.

## Open questions

- Can the skill-library idea work for code, browser, or data-analysis agents?
- How should failed skills be revised, deleted, or trusted?