---
title: Efficient / Tiny ML
tags: [efficiency, edge, deployment]
---

# Efficient / Tiny ML

Goal: models that run **fast**, **small**, and **cheap**—training efficiency matters, but deployment (latency, memory, watts) is often the bottleneck for adoption.

## Core techniques

- **Architecture:** depthwise separable convolutions (MobileNet-style), width/multiplier tradeoffs.
- **Compression:** pruning (magnitude, structured), knowledge distillation, low-rank factorization.
- **Quantization:** post-training vs quantization-aware training (QAT); INT8 inference paths.

## Starter papers (vault)

- [[papers/tinyml-survey-ml-oriented]] — landscape / taxonomy.
- [[papers/knowledge-distillation-hinton-2015]]
- [[papers/mobilenets-efficient-mobile-vision]]
- [[papers/quantization-int8-jacob-2018]]
- [[papers/lottery-ticket-hypothesis]]

## Synergy with other pillars

- **Data-centric:** bad slices dominate edge metrics; fixing data can beat squeezing FLOPs.
- **XAI:** sparse / quantized models may produce brittle attributions—evaluation matters.

Follow [[research/roadmap]] Phase 1.
