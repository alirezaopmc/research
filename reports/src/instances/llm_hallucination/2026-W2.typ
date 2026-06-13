#import "../../templates/weekly-report.typ": *
#import "../../lib/components/section.typ": (
  subsection-heading, subsubsection-heading, content-heading,
  content-paragraph, content-equation, content-nested,
)

#show: weekly-report.with(
  number: 2,
  period: "June 6 - June 12, 2026",
  project: "Hallucination in Large Language Models",
)

#tldr[
  Reviewed transformer and LLM fundamentals, then deep-dived into sparse
  autoencoders (SAEs). Experimented with SAELens and related libraries in Colab
  notebooks. Identified a strong survey and other resources to narrow a research
  gap next week.
]

#highlights(
  [Reviewed the mathematical foundations of transformers and LLMs.],
  [Ran hands-on experiments with SAELens and related tooling in Colab notebooks.],
  [Collected high-quality resources—including a key SAE survey—to guide gap-finding
    next week.],
)

#accomplishments(
  research: [
    #content-heading[Math of LLMs and SAEs]

    #subsection-heading[LLMs]

    #content-paragraph[
      + Layer $l$ maps tokens to hidden states $h^(l) in RR^d$.
      + Training fits next-token distribution $P(x_t | x_(<t))$ via softmax on final layer.
    ]

    #subsection-heading[SAEs]

    #content-paragraph[
      + SAEs target layer activations from the LLM.
      + Neurons are *polysemantic*: one unit fires for many unrelated concepts (superposition).
      + SAE expands activation space into sparse, *monosemantic* features for interpretability.
    ]

    #content-nested[
      #subsubsection-heading[Encoder]

      #content-paragraph[
        Maps a dense activation $x$ from an LLM layer to a higher-dimensional
        hidden layer via $W_"enc"$ and ReLU:
      ]

      #content-equation[
        $ f(x) = "ReLU"(x W_"enc" + b_"enc") $
      ]

      #subsubsection-heading[Sparsity constraint]

      #content-paragraph[
        An L1 penalty $lambda ||f(x)||_1$ in the loss pushes most hidden units to
        zero so only a few features activate at once.
      ]

      #subsubsection-heading[Decoder]

      #content-paragraph[
        Reconstructs the original activation from sparse features via $W_"dec"$:
      ]

      #content-equation[
        $ hat(x) = f(x) W_"dec" + b_"dec" $
      ]

      #subsubsection-heading[Training objective]

      #content-paragraph[
        Minimize reconstruction error while enforcing sparsity:
      ]

      #content-equation[
        $ "Loss" = ||x - hat(x)||_2^2 + lambda sum_i |f(x)_i| $
      ]

      #v(0.35em, weak: true)
      - Key resource: #link("https://arxiv.org/pdf/2503.05613v3")[A Survey on Sparse Autoencoders].
    ]
  ],
  implementation: [
    - Prototyped SAELens workflows in Colab notebooks to load models, extract
      activations, and inspect sparse features.
      Colab: #link("https://colab.research.google.com/github/jbloomAus/SAELens/blob/main/tutorials/training_a_sparse_autoencoder.ipynb")[Training a sparse autoencoder].
  ],
)

#challenges(
  technical: (
    (
      issue: [Colab runtime limits and library version mismatches slowed longer
        SAELens runs.],
    ),
  ),
  theoretical: (
    [Research gap not yet pinned down—need to map survey coverage against open
      problems in hallucination and mechanistic interpretability.],
  ),
)

#goals[
  - Work through the SAE survey and related resources to articulate a concrete gap.
  - Extend Colab experiments to one end-to-end feature-inspection pass on a small model.
  - Connect SAE findings back to the hallucination thread or other interpretability threads.
]
