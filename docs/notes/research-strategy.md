# Research Strategy & Proposal Blueprint

## Core Thesis

- **Title:** *Interpretability of Internal Knowledge-Awareness Signals in Large Language Models: Analysis, Detection, and Mitigation of Hallucination Using Sparse Autoencoder (SAE) Features*
- **Discipline:** M.Sc. Algorithms & Computation, University of Tehran
- **Core Hypothesis:** Mid-layer activations decomposed via Sparse Autoencoders (SAEs) isolate monosemantic epistemic confidence signals, enabling pre-generation hallucination detection and lightweight intervention under constrained compute ($\le 1\times$ GPU / Colab T4).

---

## Research Questions (RQs)

1. **RQ1 (Representation / Disentanglement):** Do sparse features from mid-layer SAEs separate epistemic uncertainty (model lacks knowledge) from ontological falsehood cleaner than raw linear probes?
2. **RQ2 (Detection / Monitoring):** Can a lightweight classifier over $k$-sparse SAE activations reliably flag high-risk hallucinated responses before final token decoding?
3. **RQ3 (Intervention / Policy):** What is the trade-off (accuracy vs. coverage) when using feature clamping (steering) or calibrated early abstention (*"I don't know"*) triggers?

---

## Methodology & Execution Pipeline

```
[Open LLM (e.g. Gemma 2 2B/9B)]
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
- Execution: Inference-only evaluation on Colab T4 / single 16–24GB GPU.

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

## Step-by-Step Proposal Finalization Checklist

- [ ] **Step 1:** Read `[[papers/gemma-scope]]` and `[[papers/geometry-of-truth]]`.
- [ ] **Step 2:** Verify Colab T4 runtime can load Gemma-2-2B-IT + Gemma Scope SAE via `sae-lens`.
- [ ] **Step 3:** Finalize proposal YAML files (`proposal/src/content/fa/body/meta/topic.yaml` and `methodology.yaml`).
- [ ] **Step 4:** Build and review proposal: `make proposal`.
