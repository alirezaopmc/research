// Surfaces — white only; structural strokes delegated to borders.typ.
#import "colors.typ": color-white

#let section-card(body, inset: (x: 0pt, y: 0pt), width: 100%) = block(
  width: width,
  fill: color-white,
  inset: inset,
)[#body]

#let subsection-band(body, inset: (x: 0pt, y: 0pt), width: 100%) = block(
  width: width,
  fill: color-white,
  inset: inset,
)[#body]

#let cover-hero-band(body, inset: (x: 0pt, y: 0pt), width: 100%) = block(
  width: width,
  fill: color-white,
  inset: inset,
)[#body]

#let accent-rule(width: 100%) = line(length: width, stroke: 0.5pt + color-white)
