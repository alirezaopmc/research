# Research Strategy & Proposal Blueprint

## Core Thesis

- **Title:** *Investigating Internal Representations for Understanding and Evaluating Large Language Model Behavior* (بررسی بازنمایی‌های درونی برای فهم و ارزیابی رفتار مدل‌های زبانی بزرگ)
- **Discipline:** M.Sc. Algorithms & Computation, University of Tehran
- **Research scope:** Exploratory study of the relationship between internal representations and observable behavior in selected open-weight LLMs on a limited number of tasks. Committed: internal representations as a lens for understanding and evaluating behavior. Open: whether the contribution is an analysis method, evaluation approach, predictive model, or intervention experiment (one primary application, at most one secondary).
- **Initial case study:** factual errors in knowledge-based QA. Gemma 2 2B with Gemma Scope SAEs on a Colab T4 is the initial candidate setup, not a commitment. The RQs and pipeline below describe this case study; the proposal's RQs are the broader three in `proposal/src/content/fa/body/meta/topic.yaml`.

---

## Research Questions (RQs)

1. **RQ1 (Representation / Disentanglement):** Do sparse features from mid-layer SAEs separate epistemic uncertainty (model lacks knowledge) from ontological falsehood cleaner than raw linear probes?
2. **RQ2 (Detection / Monitoring):** Can a lightweight classifier over $k$-sparse SAE activations reliably flag high-risk hallucinated responses before final token decoding?
3. **RQ3 (Intervention / Policy):** What is the trade-off (accuracy vs. coverage) when using feature clamping (steering) or calibrated early abstention (*"I don't know"*) triggers?

---

## Methodology & Execution Pipeline

```
[Open LLM (Gemma 2; scale per execution protocol)]
       │
       ▼ (Forward pass on QA benchmark)
[Extract Residual Stream / MLP Activations]
       │
       ▼ (Load Pretrained Dictionaries: Gemma Scope / SAELens)
[Sparse Feature Decomposition (SAEs)]
       │
   ┌───┴────────────────────────────────────────┐
   ▼                                            ▼
[Feature Discovery & Probing]           [Intervention / Action]
- Correlate features with truth/error   - Feature Clamping / Steering
- AUROC on factual confidence           - Dynamic Abstention Thresholds
```

### Compute Budget Constraint
- **No SAE pretraining from scratch required.** Use open pretrained SAE weights from **Gemma Scope** via `SAELens`.
- Execution: Inference-only evaluation on Google Colab Pro (default: Gemma 2 2B + SAE on Colab T4; larger checkpoints only via protocol update with logged rationale).

---

## Evaluation Framework

### Datasets
- **TriviaQA / NQ-Open:** Factual entity recall and broad knowledge.
- **PopQA:** Long-tail knowledge to stress-test knowledge boundaries.
- **TruthfulQA / CounterFact:** Disentangling common misconceptions from true knowledge gaps.

### Baselines
1. **Uncertainty Baselines:** Output token log-probability entropy, predictive entropy.
2. **Sampling Baselines:** Self-consistency / semantic clustering (temperature $>0$).
3. **Internal Baselines:** Linear Probes (logistic regression on raw hidden states), Representation Engineering (RepE reading vectors).

### Metrics
- Detection: AUROC, AUPR, F1-score for hallucinated vs. factual generations.
- Mitigation: Factuality accuracy @ fixed abstention rates (Pareto frontier).

---

## Priority Reading List

Read with the template in `[[papers/_template]]`:

| Priority | Slug | Topic | Key Paper |
|:---|:---|:---|:---|
| 1 | `[[papers/gemma-scope]]` | Tooling / Free SAEs | Lieberum et al. (2024), *Gemma Scope* |
| 2 | `[[papers/scaling-monosemanticity]]` | SAE Features | Templeton et al. (2024), *Scaling Monosemanticity* |
| 3 | `[[papers/geometry-of-truth]]` | Truth Probing | Marks & Tegmark (2023), *The Geometry of Truth* |
| 4 | `[[papers/language-models-know]]` | Internal Calibration | Kadavath et al. (2022), *Language Models (Mostly) Know What They Know* |
| 5 | `[[papers/representation-engineering]]` | Steering / Mitigation | Zou et al. (2023), *Representation Engineering* |
| 6 | `[[papers/sae-survey]]` | Comprehensive Overview | Gao et al. / Survey (2025), *A Survey on Sparse Autoencoders* |

---

## Proposal Decisions (2026-10-18)

- **Framing:** broad thesis title; SAE-based factual-error detection is the explicit case study (RQ1–RQ2).
- **Steering:** conditional (RQ3 and §4-2 stage 3); runs only if RQ1–RQ2 evidence supports it.
- **Compute:** Google Colab Pro; Gemma 2 2B with Gemma Scope residual SAEs (see 2026-10-27 scale decision below).
- **Thesis type:** applied (کاربردی). **Timeline:** 12 months from Aban 1405, six two-month sequential phases.
- **Font:** XB Niloofar kept; redistribution rights still unverified.
- **Open inputs:** supervisor and advisor rank/share/workplace/signature, student signature, approval date (1405/05/25 predates today).

## Proposal Review Decisions (2026-10-27)

- **RQ2 timing:** detection uses activations of the single evaluated answer; "before generation" removed to match the semantic-entropy baseline.
- **Label leakage:** consistency labels come from sampling separate from evaluation samples; labeling rule (match or judge) fixed before runs.
- **Success criteria:** numeric thresholds live only in `[[notes/proposal-execution-protocol]]` (not binding proposal text); evaluated on validation/test, not training.
- **Proposal wording (2026-10-27):** models, datasets, and baseline *instances* named only in execution protocol; body uses families; no pre-committed winners in goals/metrics.
- **Compute:** Colab Pro with GPU availability variable; quantization treated as a sensitivity check that is reported separately.
- **Model scale:** Proposal body stays family-level (open LLM + published SAEs); operational default **Gemma 2 2B** in `[[notes/proposal-execution-protocol]]`. Optional scale-up (e.g. 9B) is not a proposal commitment.
- **Novelty:** softened to "not reported in the reviewed literature"; Dubanowska et al. (2025, arXiv:2509.19372) added as the nearest OOD neighbor.
- **Language:** Google Colab Pro written as گوگل کولب پرو; open-source gloss moved to first occurrence in §4-1-4.
- **Open:** approval date 1405/05/25 predates the current date (Aban 1405); supervisor/advisor rank, share, and signatures still placeholders.

## Direction check (2026-10-27)

Full sources and the recommended framing: [[notes/direction-validation-2026-10]].

- **Keep** the broad title, Gemma 2 2B, published Gemma Scope weights, and the stable-vs-unstable error split.
- **Demote** SAEs from the contribution to one comparison arm. Published 2025 results (Kantamneni; Dubanowska; AxBench) say they do not beat probes or prompting on detection and steering.
- **Do not switch** to Gemma Scope 2, transcoders, or attribution graphs. Those answer a circuit question at a higher engineering cost.
- **Center** selective answering: accuracy at fixed abstention, with output uncertainty and a linear probe as the serious baselines.
- **Real-world link:** one small hand-built transfer set (game-lore against a fixed wiki, or a course FAQ). No medical or enterprise-RAG deployment claim.
- **Graphs:** one knowledge graph as the applied slice’s ground truth, checked with k-hop lookup. Attribution graphs and a GNN stay out of the main method. See the graph section in [[notes/direction-validation-2026-10]].
- Proposal text is unchanged until this framing is accepted.

## Step-by-Step Proposal Finalization Checklist

- [ ] **Step 1:** Read `[[papers/gemma-scope]]` and `[[papers/geometry-of-truth]]`.
- [ ] **Step 2:** Verify Colab T4 runtime can load Gemma-2-2B-IT + Gemma Scope SAE via `sae-lens`.
- [ ] **Step 3:** Finalize proposal YAML files (`proposal/src/content/fa/body/meta/topic.yaml` and `methodology.yaml`).
- [ ] **Step 4:** Build and review proposal: `make proposal`.
