---
title: Study roadmap — efficient ML, data-centric AI, XAI
date: 2026-05-09
---

# Roadmap

Purpose: build enough literacy in three pillars to decide whether you enjoy the **research style** (reading, reproducing small experiments, critiquing assumptions) and the **engineering style** (deployment constraints, datasets, evaluation).

Hub: [[research/topics/focus-areas]].

## Phase 0 — Orientation (≈1–2 weeks)

| Step | Action |
|------|--------|
| Skim | One survey per pillar: [[papers/tinyml-survey-ml-oriented]], skim data-centric framing (topic note + Confident Learning intro), skim [[papers/shap-neurips-2017]] or [[papers/lime-kdd-2016]] abstracts |
| Tools | Pick **one** tiny runtime target for toy demos later (e.g. ONNX Runtime, `torch.quantization` docs, or Edge Impulse free tier—choose one and stay consistent) |
| Writing | In personal notes: “What felt tedious vs exciting?” after each skim |

## Phase 1 — Efficient / Tiny ML depth (≈3–4 weeks)

Read (order flexible):

1. [[papers/knowledge-distillation-hinton-2015]]
2. [[papers/mobilenets-efficient-mobile-vision]]
3. [[papers/quantization-int8-jacob-2018]]
4. [[papers/lottery-ticket-hypothesis]]

Hands-on (pick **one**):

- Train a small CNN on CIFAR-10 → prune or distill → measure latency/size **before/after** on CPU (sandbox experiment; log in `sandbox/` per repo rules).

Books / courses (optional but strong signal):

- **Book:** Pete Warden & Daniel Situnayake — *TinyML* (O’Reilly). Practical microcontroller framing.
- **Course:** MIT **TinyML and Efficient Deep Learning** (materials vary by year; search course number **6.S965** / related offerings for open lectures & slides).

## Phase 2 — Data-centric AI (≈3–4 weeks)

Read:

1. [[papers/confident-learning-northcutt]]
2. [[papers/dataset-cartography]]

Themes to internalize: label noise, slice-level failures, data versioning, weak supervision—not only bigger models.

Courses / talks:

- **Stanford CS329T:** Trustworthy Machine Learning (covers robustness, data issues, evaluation mindset—overlap with XAI).
- Andrew Ng’s **data-centric AI** lectures / interviews (conceptual framing; pair with the papers above).

Hands-on:

- Run **one** cleaning iteration on a small noisy subset (e.g. Confident Learning tutorial notebook)—measure validation delta.

## Phase 3 — Explainable AI (≈2–3 weeks)

Read:

1. [[papers/lime-kdd-2016]]
2. [[papers/shap-neurips-2017]]

Follow-up (when motivated): Grad-CAM / attribution zoo—add a paper note when you pick one concrete method for a project.

Hands-on:

- Apply LIME or SHAP to **one** tabular or vision model you trained in Phase 1; write 5 bullets: what helped, what misled, runtime cost.

## Phase 4 — Decision checkpoint

Answer honestly:

1. Which pillar produced the **most ideas** you wanted to try next?
2. Did you prefer **proving impossibility/tradeoffs**, **building demos**, or **measuring human-facing explanations**?
3. Compute budget: everything above should stay feasible on **≤1× H100** or consumer GPU; if not, narrow scope.

Next steps if still interested: pick **one** intersection (e.g. explainability under quantization; data-centric evaluation of compressed models) and draft a one-page problem statement for an advisor.

## Paper index (this vault)

| Pillar | Notes |
|--------|--------|
| Efficient / Tiny ML | [[papers/knowledge-distillation-hinton-2015]], [[papers/mobilenets-efficient-mobile-vision]], [[papers/quantization-int8-jacob-2018]], [[papers/lottery-ticket-hypothesis]], [[papers/tinyml-survey-ml-oriented]] |
| Data-centric AI | [[papers/confident-learning-northcutt]], [[papers/dataset-cartography]] |
| XAI | [[papers/lime-kdd-2016]], [[papers/shap-neurips-2017]] |
