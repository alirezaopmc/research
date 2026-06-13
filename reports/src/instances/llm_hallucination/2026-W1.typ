#import "../../templates/weekly-report.typ": *

#show: weekly-report.with(
  number: 1,
  period: "May 30 - June 5, 2026",
  project: "Hallucination in Large Language Models",
)

#tldr[
  Reviewed literature on LLM hallucination and model internals. Skimmed
  industry-related work. Covered sparse autoencoders (SAEs), circuit tracing,
  and recent surveys.
]

#highlights(
  [Reviewed 12 items on hallucination and interpretability literature; skimmed
    4 items on sparse autoencoders.],
  [Still deciding whether to keep reading survey literature or focus on circuit
    tracing inside models.],
  [Next week: read more literature and try one small method on a small model.],
)

#accomplishments(
  research: [
    - Skimmed sparse autoencoder (SAE) literature (4 items):
      #link("https://arxiv.org/pdf/2502.05407")[Dictionary Learning: The Complexity of Sparse Superposed Features with Feedback],
      #link("https://transformer-circuits.pub/2023/monosemantic-features/index.html")[Towards Monosemanticity],
      #link("https://arxiv.org/pdf/2503.05613v3")[A Survey on Sparse Autoencoders],
      #link("https://arxiv.org/pdf/2406.04093")[Scaling and evaluating sparse autoencoders].
    - Reviewed hallucination and interpretability literature (12 items):
      #link("https://www.anthropic.com/research/natural-language-autoencoders")[Natural Language Autoencoders],
      #link("https://arxiv.org/pdf/2406.11944")[Transcoders Find Interpretable LLM Feature Circuits],
      #link("https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html")[Scaling Monosemanticity],
      #link("https://arxiv.org/pdf/2309.08600")[Sparse Autoencoders Find Highly Interpretable Features in Language Models],
      #link("https://transformer-circuits.pub/2025/attribution-graphs/methods.html")[Circuit Tracing],
      #link("https://www.anthropic.com/research/tracing-thoughts-language-model")[Tracing the thoughts of a large language model],
      #link("https://arxiv.org/pdf/2505.12151v3")[Reasoning LLM Errors Arise from Hallucinating Critical Problem Features],
      #link("https://www.anthropic.com/research/teaching-claude-why")[Teaching Claude why],
      #link("https://arxiv.org/pdf/2509.04664")[Why Language Models Hallucinate],
      #link("https://arxiv.org/pdf/2510.06265")[Large Language Models Hallucination: A Comprehensive Survey],
      #link("https://arxiv.org/pdf/2510.24476")[Mitigating Hallucination in LLMs],
      #link("https://arxiv.org/pdf/2504.09522v1")[How new data permeates LLM knowledge and how to dilute it].
    - Skimmed industry literature (4 items):
      #link("https://research.google/blog/turboquant-redefining-ai-efficiency-with-extreme-compression/")[TurboQuant],
      #link("https://arxiv.org/pdf/2412.03220v1")[Survey of LLM Architectures],
      #link("https://deepmind.google/blog/accelerating-mathematical-and-scientific-discovery-with-gemini-deep-think/")[Gemini Deep Think],
      #link("https://deepmind.google/blog/facts-grounding-a-new-benchmark-for-evaluating-the-factuality-of-large-language-models/")[FACTS Grounding].
  ],
)

#challenges(
  technical: (
    [Need to set up a basic environment for circuit tracing or interpretability experiments on Gemma 4 (Colab or department GPU).],
  ),
  theoretical: (
    [Still deciding whether to focus on survey literature or circuit tracing
      inside models.],
  ),
)

#goals[
  - Read more survey literature and learn the main ideas and related work.
  - Read more industry literature on real-world work.
  - Run a basic interpretability experiment on Gemma 4 (Colab or department GPU).
]
