---
title: "Language Models (Mostly) Know What They Know"
authors: "Kadavath et al. (Anthropic)"
year: 2022
venue: arXiv
arxiv: "2207.05221"
url: "https://arxiv.org/abs/2207.05221"
tags: ["calibration", "epistemic-uncertainty", "hallucination", "probing"]
topic: "Internal model calibration on question answering"
paper_abstract: UNREAD
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **Paper:** [arXiv:2207.05221](https://arxiv.org/abs/2207.05221)

## TL;DR

Evaluates whether LLMs possess well-calibrated internal probabilities regarding whether they know the answer to a question before generating it.

## Why it matters (hype / industry / cost)

- **Compute:** Inference-only analysis on standard QA datasets (TriviaQA, MMLU).
- **Hype / market:** One of the earliest comprehensive studies on internal self-knowledge and calibration in LLMs.
- **Industry:** Relevant for selective prediction and safety abstention filters.
- **Topic fit:** Theoretical baseline for defining "knowledge awareness" vs. output-level verbalized hallucination.

## Method

- Formulated QA prompts and measured model's calibrated probability of knowing the answer ($P(\text{True})$).
- Compared model self-evaluation with probe predictions from internal states.

## Results

- Larger models exhibit well-calibrated internal knowledge boundaries, even when greedy decoding generates hallucinations.

## Notes / quotes

- Relates to [[notes/research-strategy]] and [[papers/geometry-of-truth]].

## Open questions

- Can SAE features pinpoint the exact failure point where an unconfident state gets overridden by fluency generation?
