# Efficient Sequence Models

## Positioning

> Subquadratic alternatives to Transformer attention: **state space models (SSM)**, selective/recurrent mechanisms, linear-time convolutions, and hybrid architectures. Goal: long-context modeling with better train/inference scaling than dense attention.

## Core Questions

- When do SSM / Mamba-class models match Transformer quality on language vs audio/genomics?
- What breaks selective state spaces vs content-based attention (copy, induction, retrieval)?
- How do hardware-aware implementations (scan, fused kernels) change the cost story?
- Where do hybrids (attention + SSM layers) win over pure stacks?

## Why It Is Market-Relevant

> **Compute:** …
> **Hype / market:** …
> **Industry:** …

## Low-Compute Strategy

- Read foundational SSM/Mamba papers; map the design space (S4 → Mamba → successors).
- Run inference-only benchmarks: throughput vs context length on open checkpoints.
- Small ablations on synthetic tasks (selective copy, induction) before any training.

## Related Papers

- [[papers/efficient-sequence-models/mamba-selective-ssm]]

## Open Threads

> What you want to explore next—fill as you read.
