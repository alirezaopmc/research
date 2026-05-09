---
title: Data-centric AI
tags: [datasets, labels, evaluation]
---

# Data-centric AI

Shift mindset from “hold data fixed, scale model” toward **iterative dataset improvement**: labeling quality, slice errors, coverage, versioning, and measurement.

## What to watch for

- Confusion between **shortcut learning** vs true generalization.
- **Slice-level** metrics (not only aggregate accuracy).
- Processes: error analysis → targeted collection or relabeling → retrain → repeat.

## Starter papers (vault)

- [[papers/confident-learning-northcutt]]
- [[papers/dataset-cartography]]

## Synergy with other pillars

- **Efficient ML:** smaller models amplify dataset weaknesses—clean data + small model often beats dirty data + large model on edge.
- **XAI:** explanations should surface **which slices** fail; ties to human-in-the-loop labeling.

Follow [[research/roadmap]] Phase 2.
