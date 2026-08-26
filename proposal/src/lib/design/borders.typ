// Reusable bordered frames (official cover style).
#import "colors.typ": color-ut-blue

#let stroke-form = 0.75pt + color-ut-blue
#let stroke-form-light = 0.5pt + color-ut-blue
#let form-border-inset = 10pt
#let form-border-gap = 4pt

#let double-border-frame(
  body,
  inset: form-border-inset,
  gap: form-border-gap,
  width: 100%,
) = block(
  width: width,
  fill: white,
  stroke: stroke-form,
  inset: gap,
)[
  #block(
    width: 100%,
    fill: white,
    stroke: stroke-form,
    inset: inset,
  )[#body]
]

#let subsection-title-box(
  body,
  inset: (x: 8pt, y: 5pt),
  width: 100%,
) = block(
  width: width,
  fill: white,
  stroke: stroke-form-light,
  inset: inset,
)[#body]
