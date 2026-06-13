---
title: "ICLAD: In-Context Learning for Unified Tabular Anomaly Detection Across Supervision Regimes"
authors: "Jack Yi Wei, Narges Armanfard"
year: 2026
venue:
arxiv: 2603.19497
url: https://arxiv.org/abs/2603.19497
tags: [icl, tabular, anomaly-detection]
topic: llm-techniques
paper_abstract: READ
paper_content: UNREAD
paper_reproduced: 'NO'
paper_favorite: false
paper_to_read: true
---

## Paper link

- **arXiv:** https://arxiv.org/abs/2603.19497

## TL;DR

Trains a meta-learned foundation model for tabular anomaly detection that handles one-class, unsupervised, and semi-supervised regimes via in-context conditioning.

## Novelty

Novel unified ICL framing across anomaly-detection supervision regimes and datasets.

## Compute Cost

High: meta-learning over synthetic tabular tasks and 57-dataset evaluation likely exceeds casual single-GPU reproduction.

## Trend and Hype

Moderate-to-high: tabular foundation models and anomaly detection have industry pull.

## Market Demand

Strong in fraud, monitoring, industrial quality, and security anomaly detection.

## Reproducibility

**Not reproducible on 1x RTX 4090 + Colab Pro as a full study:** small inference or baseline comparisons may be possible, but training the foundation model is likely too expensive.

## Method

From the abstract: Anomaly detection on tabular data is commonly studied under three supervision regimes, including one-class settings that assume access to anomaly-free training samples, fully unsupervised settings with unlabeled and potentially contaminated training data, and semi-supervised settings with limited anomaly labels. Existing deep learning approaches typically train dataset-specific models under the assumption of a single supervision regime, which limits their ability to leverage shared structures across anomaly...

## Results

Reported results claim improvements over relevant CoT/ICL/prompting, routing, benchmark, or analysis baselines. Treat exact numbers as worth checking in the full paper before relying on them.

## Notes / quotes

- Abstract read only; PDF not downloaded.
- Related: [[research/topics/llm-techniques]]

## Open questions

- What is the smallest experiment that preserves the paper's main claim under a 1x RTX 4090 / Colab Pro budget?
- Are the gains from the core method, the model choice, or the evaluation setup?
