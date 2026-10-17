// Shared figure primitives: Persian numbering, caption, nodes, arrows, band labels.
#import "../../design/colors.typ": color-ut-blue
#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-base-body, text-base-label
#import "../shared.typ": to-persian-digits

#let diagram-stroke = 0.75pt + color-ut-blue
#let diagram-stroke-emphasis = 1.5pt + color-ut-blue
#let diagram-stroke-rule = 0.5pt + color-ut-blue
#let diagram-arrow-size = 6pt
#let diagram-arrow-length = 0.7cm

// Diagram text is never justified: body text is justified by default.
#let body-figure(body, caption) = figure(
  align(center)[
    #set par(justify: false)
    #body
  ],
  caption: text-base-body(caption),
  supplement: [شکل],
  numbering: number => to-persian-digits(number),
  gap: space-sm,
)

// Body table with a numbered caption above it (جدول ۱).
#let body-table(body, caption) = figure(
  [
    #set par(justify: false)
    #body
  ],
  kind: table,
  caption: figure.caption(position: top, text-base-body(caption)),
  supplement: [جدول],
  numbering: number => to-persian-digits(number),
  gap: space-sm,
)

#let diagram-node(body, width: auto, emphasis: false) = box(
  width: width,
  inset: (x: 6pt, y: 6pt),
  stroke: if emphasis { diagram-stroke-emphasis } else { diagram-stroke },
  fill: white,
)[#align(center + horizon)[#body]]

// Arrow pointing left: the reading direction of the Persian (RTL) flow.
#let diagram-arrow-left(length: diagram-arrow-length) = box(
  width: length,
  height: diagram-arrow-size,
)[
  #place(horizon + left, line(length: 100%, stroke: diagram-stroke))
  #place(horizon + left, polygon(
    fill: color-ut-blue,
    stroke: none,
    (0pt, diagram-arrow-size / 2),
    (diagram-arrow-size, 0pt),
    (diagram-arrow-size, diagram-arrow-size),
  ))
]

// Arrow pointing up: rotated left arrow, used for vertical links.
#let diagram-arrow-up(length: diagram-arrow-length) = box(
  width: diagram-arrow-size,
  height: length,
)[
  #place(center + horizon, rotate(90deg, diagram-arrow-left(length: length)))
]

#let diagram-band-top(label) = stack(
  spacing: space-stack-tight,
  text-base-label(label),
  line(length: 100%, stroke: diagram-stroke-rule),
)

#let diagram-band-bottom(label) = stack(
  spacing: space-stack-tight,
  line(length: 100%, stroke: diagram-stroke-rule),
  text-base-label(label),
)
