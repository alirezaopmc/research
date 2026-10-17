// Figure for section 4-1 (necessity): one published causal intervention, original vs. swapped.
#import "../../../design/typography.typ": text-base-body, text-base-label
#import "../../shared/figure.typ": body-figure, diagram-arrow-left, diagram-node

#let necessity-intervention-figure(content) = body-figure(
  grid(
    columns: (2.8cm, 0.4cm, 4.2cm, 0.7cm, 3.0cm, 0.7cm, 3.0cm),
    align: center + horizon,
    row-gutter: 0.8em,
    [], [], text-base-label(content.header-input), [],
    text-base-label(content.header-representation), [],
    text-base-label(content.header-output),

    text-base-label(content.row-original),
    [],
    diagram-node(width: 4.2cm)[#text-base-body(content.prompt)],
    diagram-arrow-left(),
    diagram-node(width: 3.0cm)[#text-base-body(content.original-representation)],
    diagram-arrow-left(),
    diagram-node(width: 3.0cm)[#text-base-body(content.original-output)],

    text-base-label(content.row-intervened),
    [],
    diagram-node(width: 4.2cm)[#text-base-body(content.prompt)],
    diagram-arrow-left(),
    diagram-node(width: 3.0cm, emphasis: true)[#text-base-body(content.intervened-representation)],
    diagram-arrow-left(),
    diagram-node(width: 3.0cm)[#text-base-body(content.intervened-output)],
  ),
  content.caption,
)
