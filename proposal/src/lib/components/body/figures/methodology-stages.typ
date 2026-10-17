// Figure for section 4-2 (methodology): three research stages with their outputs.
#import "../../../design/typography.typ": text-base-body, text-base-label
#import "../../shared/figure.typ": body-figure, diagram-arrow-left, diagram-stroke

#let stage-node(stage) = block(
  width: 100%,
  height: 3.6cm,
  stroke: diagram-stroke,
  inset: 8pt,
)[
  #align(center + horizon)[
    #text-base-label(stage.title)
    #v(0.4em)
    #text-base-body(stage.output)
    #if "condition" in stage [
      #v(0.4em)
      #text(size: 11pt)[#stage.condition]
    ]
  ]
]

#let methodology-stages-figure(content) = {
  let stages = content.stages
  body-figure(
    grid(
      columns: (1fr, 0.7cm, 1fr, 0.7cm, 1fr),
      align: center + horizon,
      stage-node(stages.at(0)),
      diagram-arrow-left(),
      stage-node(stages.at(1)),
      diagram-arrow-left(),
      stage-node(stages.at(2)),
    ),
    content.caption,
  )
}
