# Interactive Reading Session: Gemma Scope

- **Paper**: [Gemma Scope: Open Sparse Autoencoders Everywhere All At Once on Gemma 2](https://arxiv.org/abs/2408.05147)
- **arXiv**: `2408.05147`
- **Authors**: Tom Lieberum, Senthooran Rajamanoharan, Arthur Conmy, Lewis Smith, et al. (Google DeepMind)
- **Related Note**: [[papers/gemma-scope]]
- **Harness**: [[notes/paper-reading-harness]]

---

## Progress Overview

| Metric | Status |
| :--- | :--- |
| **Current Step** | Step 3 / 7 |
| **Current Section** | §3 Training Details & Infrastructure |
| **Page Range** | Pages 4–6 |
| **Progress** | 29% Complete (Step 2 Mastered) |
| **Questions Posed** | 9 Total (6 Completed, 3 New) |
| **Mastery Score** | 4.8 / 6.0 (80%) |

---

## Roadmap

- [x] **Step 1**: §1 Abstract & Introduction (Motivation, Scaling SAEs, Core Contributions) — *Mastered*
- [x] **Step 2**: §2 Preliminaries (SAE Formulation, JumpReLU Activation, $L_0$ Objective, STEs) — *Mastered*
- [ ] **Step 3**: §3 Training Details (Data, Sites, Sharding, 20 PiB Buffer Pipeline, Optimizer)
- [ ] **Step 4**: §4 Evaluation I (Sparsity-Fidelity Frontier, Sequence Position, Width & Feature Splitting)
- [ ] **Step 5**: §4 Evaluation II (Interpretability, Base $\to$ IT Transfer, Subsets, Precision)
- [ ] **Step 6**: §5 Open Problems (Downstream Tasks, Red-Teaming, Scalable Circuit Analysis)
- [ ] **Step 7**: Appendices (Transcoders & Standardization for Inference)

---

## Log & Scorecard

### Step 1 Evaluation (§1 Abstract & Introduction)
- **Q1 (Circuit Analysis Scope)**: Correct. Identified that mapping causal interactions across sub-layers requires comprehensive SAE coverage.
- **Q2 (Superposition)**: Correct. Captured non-orthogonal vectors packed in high-dimensional space under sparsity constraints.
- **Q3 (Instruction-Tuned SAE Utility)**: Partially complete. Clarified that IT SAEs isolate post-alignment changes (refusals, chat personas).
- **Score**: 2.5 / 3.0.

### Step 2 Evaluation (§2 Preliminaries & JumpReLU)
- **Q1 (L1 vs L0 Shrinkage)**: Correct intuition. $L_1$ adds linear continuous penalty pushing all magnitudes down; JumpReLU $L_0$ charges a fixed cost once active, leaving magnitude unpenalized.
- **Q2 (STE Bandwidth $\varepsilon$)**: Clarified. Small $\varepsilon \to$ zero gradient $\to$ thresholds never increase (no sparsity). Large $\varepsilon \to$ high variance/bias $\to$ degraded reconstruction fidelity.
- **Q3 (Variable Sparsity Benefit)**: Correct. Simple punctuation (periods, semicolons) requires few latents; complex multi-semantic concepts utilize higher dynamic capacity.
- **Score**: 2.3 / 3.0.
