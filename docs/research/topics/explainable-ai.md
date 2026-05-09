---
title: Explainable AI (XAI)
tags: [interpretability, attribution, trust]
---

# Explainable AI (XAI)

Goal: methods and evaluations that help humans **understand or audit** model behavior—distinct from raw accuracy, and tightly coupled to **risk** (medicine, finance, safety).

## Families of methods

- **Local explanations:** why this prediction (LIME-style perturbations, SHAP-style cooperative game values).
- **Attribution maps:** gradient-based saliency / CAM variants for vision.
- **Higher-level:** concept bottleneck models, mechanistic interpretability (add notes when you go deeper).

## Starter papers (vault)

- [[papers/lime-kdd-2016]]
- [[papers/shap-neurips-2017]]

## Pitfalls

- Explanations can be **persuasive but wrong**; faithfulness metrics and human studies remain active research.

## Synergy with other pillars

- **Efficient ML:** compression may change feature reliance—stress-test explanations under pruning/QAT.
- **Data-centric AI:** explanations guide **which examples** to label or fix.

Follow [[research/roadmap]] Phase 3.
