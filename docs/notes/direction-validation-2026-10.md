# Direction check — 2026-10-27

Advisory note for [[notes/research-strategy]]. It does not change the proposal text. The recommendation is: keep the broad title and the Gemma 2 2B + Gemma Scope stack; stop treating SAEs as the contribution.

## Verdict

SAEs are a usable instrument for this thesis. They are a weak bet as the thing the thesis tries to win with.

Three 2025 results, all on tasks close to this proposal, say the same thing:

- **Detection.** Kantamneni et al., ICML 2025 ([arXiv:2502.16681](https://arxiv.org/abs/2502.16681)): SAE probes do not beat logistic regression on raw activations across scarcity, imbalance, label noise, and shift. Simple baselines recover much of the “interpretability” story.
- **The nearest neighbor already in the proposal.** Dubanowska et al., EMNLP 2025 Findings ([arXiv:2509.19372](https://arxiv.org/abs/2509.19372)): representation-based hallucination detectors, including SAE features, match linear probes once a spurious correlation is controlled, and fall near chance out of distribution.
- **Steering.** Wu et al., AxBench, ICML 2025 ([arXiv:2501.17148](https://arxiv.org/abs/2501.17148)): on Gemma-2-2B and 9B, prompting beats representation steering; difference-in-means beats vanilla SAEs; SAEs are not competitive for concept detection either. A later filtered-SAE entry on the [public leaderboard](https://stanfordnlp.github.io/axbench/) improves SAE steering and still trails prompting.

A careful negative comparison is a legitimate master’s result. A proposal that promises SAE features will detect factual errors better than a probe is arguing against the published record.

## What is newer, and why not to switch

| Method | What it is better at | Fit for this thesis |
|---|---|---|
| Cross-layer transcoders and attribution graphs (Anthropic, 2025; [methods](https://transformer-circuits.pub/2025/attribution-graphs/methods.html); open release [2025-05-29](https://www.anthropic.com/research/open-source-circuit-tracing)) | Tracing a prompt-specific circuit | Different question. Heavy engineering. Graphs are large. Does not yield a cheaper abstention policy. |
| Transcoders (Dunefsky et al., NeurIPS 2024; Paulo et al., [arXiv:2501.18823](https://arxiv.org/abs/2501.18823)) | Replacing an MLP so feature-to-feature effects are linear | Better microscope, same product gap. Training one is outside the compute budget. |
| Gemma Scope 2 (McDougall et al., 2025; [blog](https://deepmind.google/blog/gemma-scope-2-helping-the-ai-safety-community-deepen-understanding-of-complex-language-model-behavior/)) | SAEs plus skip- and cross-layer transcoders for Gemma 3, including chat models | Real upgrade for jailbreaks, refusal, and chain-of-thought. Resets the stack (Gemma 3, new weights, new tooling) without answering the abstention question better. |
| Semantic-entropy probes (Kossen et al., [arXiv:2406.15927](https://arxiv.org/abs/2406.15927)) and correctness probes | One-forward-pass uncertainty and selective answering | This is the practical method. Already inside the baseline plan. Make it the main comparison, not a footnote. |

Stay on Gemma 2 2B and published Gemma Scope weights. The free dictionary is the reason the SAE arm is affordable. Training a dictionary, or moving the case study onto circuit tracing, spends the year on infrastructure.

## The question that still has room

Generic “detect hallucinations with internals” is crowded, and the OOD failure is already reported (Dubanowska; also Orgad et al., ICLR 2025, [arXiv:2410.02707](https://arxiv.org/abs/2410.02707): truthfulness is linearly readable, and the detectors do not travel across datasets).

The error split in the current proposal is the part worth keeping, with tighter neighbors:

- Ganesh, Shokri, and Farnadi, EACL 2026 ([anthology](https://aclanthology.org/2026.eacl-long.327.pdf)): many detectors track consistency, not correctness. Stable wrong answers and unstable wrong answers are different harms. TruthfulQA-style errors are often consistent; other benchmarks are mostly unstable.
- Chauhan, 2026, DECK ([arXiv:2606.02289](https://arxiv.org/abs/2606.02289)): a 2×2 of consistency and confidence. Sampling consistency catches the unstable cells. Token probabilities catch a different pair. The high-consistency, high-confidence wrong cell is the one those scorers miss.
- Phillips et al., 2026 ([arXiv:2603.21172](https://arxiv.org/abs/2603.21172)): entropy alone is not a safe abstention score at strict error targets. Adding a correctness probe improves the risk–coverage curve on TriviaQA, BioASQ, and MedicalQA. This is the evaluation shape to copy: risk at a fixed coverage, not only AUROC.

Those papers are behavioral or probe-based. They do not run the split on Gemma Scope features against a matched raw-state probe, with labels from a separate sample. That comparison is small enough for a master’s thesis and still not reported in this form. State it as a comparison, not as an expected SAE win. Cite Ganesh and DECK in the background so the committee does not think the split was invented here.

RQ3 stays conditional. If it runs, the intervention to test is abstention (and, only as a control, difference-in-means). Feature clamping is the arm AxBench already showed is weak. Do not make it the contribution.

## Real-world gap this can actually touch

Products do not load a sparse dictionary. A game studio, a support bot, or a tutor needs a policy: answer, hedge, or abstain, from one forward pass, because extra samples cost latency and money.

The harms differ by error type, which is the real-world content of the split:

- **Unstable error** (the model gives a different wrong fact each sample). Users notice. Uncertainty scoring is the right tool. Farquhar et al., Nature 2024, semantic entropy, is the strong expensive version; Kossen’s probe is the cheap version.
- **Stable error** (the same wrong fact, said confidently). This is the damaging one. A game NPC writes false lore that players treat as canon. A tutor repeats a wrong explanation. A support bot cites a policy that is not in the document. Sampling agreement looks like confidence. An external check or a correctness signal is required. Ganesh et al. make this harm distinction explicit.

A master’s project can show that policy on a public QA benchmark and on one narrow applied slice built by the student. It cannot honestly claim to fix medical, legal, or enterprise RAG. Dubanowska is the warning on RAG transfer: in-domain scores collapse out of distribution. Phillips is the reason selective prediction matters in medicine; it is motivation, not a deployment claim.

Applied slice that fits the budget and the interest in games, apps, and ordinary tools:

1. Keep TriviaQA / PopQA (or the protocol’s current set) as the scientific benchmark.
2. Add one hand-built set of about 100–200 items with gold answers: either game-lore questions against a fixed public wiki page, or a course-FAQ / student-help set. Same model, same probes, report transfer. The artifact is the risk–coverage curve on that slice, plus which error type the policy misses.
3. Skip a live product integration. The thesis delivers the measurement a product team would need before wiring abstention into an NPC or a tutor.

## What “good enough for a master’s thesis” is

Reproducible comparison, pre-registered in [[notes/proposal-execution-protocol]], on one 2B model, one published SAE, one GPU:

- Three signals: output uncertainty, linear probe on the raw state, sparse features from the published SAE.
- Two labels: correct vs wrong, and stable-wrong vs unstable-wrong, with the consistency sample kept separate from the evaluated answer.
- One metric that a user feels: factual accuracy at fixed abstention rates.
- One transfer set in a narrow applied domain.
- An explicit sentence in the thesis: if the SAE arm loses, that result stands.

That is an applied thesis. It does not need a new architecture, a new dictionary, or a result that beats the field.

## Graphs (2026-10-27)

Three different objects get called a graph. Only one of them belongs in this thesis.

| Object | Role it would play | Decision |
|---|---|---|
| Attribution graph / sparse feature circuit (Marks et al., ICLR 2025, [arXiv:2403.19647](https://arxiv.org/abs/2403.19647); Anthropic circuit tracing, 2025) | Causal graph over internal features | Leave it out. HalluSAE (2026, [arXiv:2604.16430](https://arxiv.org/abs/2604.16430)) already attributes hallucination to Gemma Scope features on Gemma-2-9B. Building the circuit is a second project. |
| Knowledge graph plus ordinary graph operations | External facts for the applied slice: entities, relations, a claimed triple, a k-hop neighborhood | Use this. It is the algorithms piece, and it is what a game, an app, or a support bot can store. |
| Graph ML (RGCN / GNN over triples or a KG) | A learned detector on the graph | Optional baseline only. Fang et al., AAAI 2025 (GCA) and KG-Guard (2026, [arXiv:2606.00328](https://arxiv.org/abs/2606.00328)) are full graph-learning papers. A GNN on a few hundred hand-built triples is a second thesis, and it has to beat “is this triple inside the k-hop neighborhood?” |

The combination that stays one thesis: the internal signals (entropy, linear probe, published SAE features) decide whether the model looks stable; the knowledge graph decides whether the stable claim is a real edge. Abstain when the model is confidently stable and the edge is missing. That is the stable-error cell sampling cannot see, and it is a check a product can run without loading a dictionary.

Build the graph small. A few hundred triples from one public game wiki, or one course FAQ, or a single Wikidata domain slice. Cite KGLens ([arXiv:2312.11539](https://arxiv.org/abs/2312.11539)) and GraphEval ([arXiv:2404.00942](https://arxiv.org/abs/2404.00942)) as the reason a graph is a factual yardstick. Node degree is the long-tail control, in the same spirit as PopQA. Do not run those frameworks on all of DBpedia.

Traditional operations to report: k-hop retrieval around the question entity, triple membership, and degree. If a later GNN loses to triple membership, write that down. The algorithm is the result the department can recognize.

## Reading to add before locking the story

- Wu et al. 2025, AxBench — before any steering experiment.
- Kantamneni et al. 2025 — before claiming sparse features help detection.
- Ganesh et al. 2026 and Chauhan 2026 — to position the error split.
- Phillips et al. 2026 — for the abstention metric.
- Kossen et al. 2024 — already the right cheap baseline; read it as method, not as a rival to displace.
- Marks et al. 2025 and HalluSAE 2026 — so the internal feature graph is not re-proposed as the contribution.
- KGLens and GraphEval — for the knowledge graph as a yardstick; KG-Guard only if a GNN baseline is actually run.

## Decision status

Recommendation only, 2026-10-27. Proposal YAML is unchanged until this framing is accepted.
