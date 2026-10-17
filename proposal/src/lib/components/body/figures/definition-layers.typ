// Figure for section 4-1 (definition): behavioral level above, mechanistic level below.
#import "../../../design/typography.typ": text-base-body, text-base-label
#import "../../shared/figure.typ": (
  body-figure, diagram-arrow-left, diagram-arrow-up, diagram-band-bottom,
  diagram-band-top, diagram-node,
)

#let definition-layers-figure(content) = body-figure(
  stack(
    spacing: 0.6em,
    diagram-band-top(content.behavior-band),
    grid(
      columns: (3.6cm, 0.7cm, 2.6cm, 0.7cm, 3.6cm, 0.7cm, 2.4cm),
      align: center + horizon,
      row-gutter: 0em,
      diagram-node(width: 3.6cm)[
        #stack(
          spacing: 0.35em,
          text-base-label(content.input),
          text-base-body(content.input-detail),
        )
      ],
      diagram-arrow-left(),
      diagram-node(width: 2.6cm)[#text-base-label(content.tokens)],
      diagram-arrow-left(),
      diagram-node(width: 3.6cm)[#text-base-label(content.layers)],
      diagram-arrow-left(),
      diagram-node(width: 2.4cm)[#text-base-label(content.output)],
      [], [], [], [], diagram-arrow-up(), [], [],
      [], [], [], [], diagram-node(width: 3.6cm, emphasis: true)[
        #text-base-label(content.representation)
      ], [], [],
    ),
    diagram-band-bottom(content.mechanistic-band),
  ),
  content.caption,
)
