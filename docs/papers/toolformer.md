---
title: 'Toolformer: Language Models Can Teach Themselves to Use Tools'
authors: Timo Schick et al.
year: 2023
venue: NeurIPS
arxiv: '2302.04761'
url: https://arxiv.org/abs/2302.04761
tags:
- agents
- tool-use
- self-supervision
- llm
paper_abstract: UNREAD
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
---

## Paper link

- **Paper:** https://arxiv.org/abs/2302.04761

## TL;DR

Toolformer shows that language models can create their own tool-use training data and learn when to call tools through self-supervised fine-tuning.

## Why it matters (hype / industry / cost)

- **Compute:** full reproduction needs training, but the data-generation idea can be studied at small scale.
- **Hype / market:** tool use is central to agent products.
- **Industry:** APIs, calculators, search, databases, calendars, and internal tools.
- **Pillar fit:** useful bridge from prompting to trainable tool-use behavior.

## Method

The model samples possible API calls in text, keeps calls that improve likelihood of future tokens, and fine-tunes on the filtered examples.

## Results

Models learn to use tools such as calculators, search, translation, and calendars while preserving general language ability.

## Notes / quotes

- Interesting because it reduces dependence on expensive human labels.
- Good inspiration for synthetic tool-use datasets.

## Open questions

- Can this be adapted to trajectory-level agent tasks?
- What filtering signal works when tool calls affect long-horizon success rather than next-token likelihood?