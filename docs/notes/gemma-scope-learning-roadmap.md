# Gemma Scope Learning Roadmap

This is the research companion behind `learning/`. The web page teaches the
concepts; this note keeps the experiment contract and handoff rules durable.

The active web track is the original 2024 Gemma Scope release for Gemma 2.
Gemma Scope 2 is a separate later release for Gemma 3 with transcoders and
cross-layer tools; it is future work, not an interchangeable runtime.

## Journey

1. **Master the instrument** — SAE decomposition, JumpReLU, L0, STEs, sites, and metrics.
2. **Wire the path** — Gemma 2 2B, one canonical residual SAE, one short prompt, shape and reconstruction checks.
3. **Find coherent features** — inspect top activating examples and record mixed, positional, or dead-feature behavior.
4. **Validate the signal** — compare raw hidden-state and SAE-feature probes with matched splits and labels.
5. **Test generalization** — include topic shifts, negations, and held-out true/false datasets.
6. **Earn intervention** — only after detection is stable, test feature clamping or abstention and measure capability side effects.

## First experiment contract

Use a small inference-only run that fits a Colab T4 or a single 16–24GB GPU:

- Load Gemma 2 2B and one canonical residual-stream SAE from SAE Lens.
- Start with a tiny validation slice and CPU shape checks.
- Record activation shape, feature shape, mean L0, reconstruction error, runtime, and peak memory.
- Inspect 10–20 features using top activating examples.
- Fit matched raw-state and SAE-feature probes on a small true/false dataset.
- Report AUROC, AUPR, F1, calibration, runtime, and memory.

Do not train an SAE from scratch, call one feature “truth” from one example, or
claim that Gemma Scope detects hallucinations. It provides reusable analysis
infrastructure; the thesis experiments must establish task-specific evidence.

## Colab protocol pages

The learning lab expands each runway gate into a standalone scaffold:

- [A — Wire the microscope](../../learning/papers/gemma-scope/experiments/a-wire-the-microscope/)
  — model/SAE compatibility, shapes, reconstruction, L0, runtime, and memory.
- [B — Find features worth testing](../../learning/papers/gemma-scope/experiments/b-find-features/)
  — activation strata, confounds, close counterexamples, and a feature ledger.
- [C — Run the fair comparison](../../learning/papers/gemma-scope/experiments/c-fair-comparison/)
  — matched raw-state and SAE probes with leakage controls and calibration.
- [D — Earn intervention](../../learning/papers/gemma-scope/experiments/d-earn-intervention/)
  — held-out selection, dose response, side effects, and causal controls.

These pages are instructions and pseudocode for a clean Colab runtime, not
executed notebooks.

## Research update

The practical sequence is supported by the current SAE Lens loading guide and
Gemma Scope model card: begin with a canonical SAE, make the hook and tensor
contract explicit, and measure reconstruction before interpreting features.
Recent SAE evaluation work strengthens the next gates: inspect close
non-activating examples rather than only top activations, compare sparse
features with a matched raw-state baseline, and use held-out causal tests
before calling an intervention meaningful.

Primary links:

- [Gemma Scope paper](https://arxiv.org/abs/2408.05147)
- [Gemma Scope 2B residual model card](https://huggingface.co/google/gemma-scope-2b-pt-res)
- [SAE Lens usage](https://decoderesearch.github.io/SAELens/latest/usage/)
- [Neuronpedia Gemma Scope explorer](https://www.neuronpedia.org/gemma-scope)
- [SAEBench](https://arxiv.org/abs/2503.09532)
- [Gemma Scope 2 official overview](https://deepmind.google/blog/gemma-scope-2-helping-the-ai-safety-community-deepen-understanding-of-complex-language-model-behavior/)

Separate paper-reported facts, locally reproduced measurements, and thesis
hypotheses in every experiment summary.

## Handoff instructions for future agents

1. Read the root `AGENTS.md`, `docs/notes/research-strategy.md`, this file, and the relevant paper note before editing.
2. Keep all long-running or messy work under `sandbox/<experiment-slug>/`.
3. Start or update `sandbox/<experiment-slug>/AGENT_LOG.md` with the exact environment, commands, model and SAE IDs, data slice, and timestamps.
4. Keep raw checkpoints, datasets, PDFs, and large result dumps out of git.
5. Promote only reproducible commands, compact metrics, limitations, and decisions into `docs/papers/` or `docs/notes/`.
6. Separate paper-reported results, locally reproduced results, and thesis hypotheses in every summary.
7. Before changing the experiment, state which baseline, metric, or compute constraint is changing.
8. For Colab/VSC integration, make the notebook or script restartable from a clean runtime and expose model, SAE, layer, site, dataset slice, seed, and device as explicit configuration.
9. Stop at the first failed invariant: shape mismatch, unexpected activation norm, implausible L0, reconstruction failure, data leakage, or unavailable GPU memory.
10. Leave the next agent a short “next action” and “known failure” entry.

## Related reading

- [[papers/gemma-scope]]
- [[papers/scaling-monosemanticity]]
- [[papers/geometry-of-truth]]
- [[papers/language-models-know]]
- [[papers/representation-engineering]]
