// Numbered section heading + subsection heading primitives.
#import "../design/tokens.typ": *
#import "../design/typography.typ": (
  text-section, text-content-heading, text-subsection, text-subsubsection,
)

#let section-heading(number, title) = [
  #v(space-section, weak: true)
  #text-section[#number. #title]
  #v(space-xs, weak: true)
  #line(length: 100%, stroke: stroke-rule + color-rule)
  #v(space-sm, weak: true)
]

#let subsection-heading(title) = [
  #v(space-subsection, weak: true)
  #text-subsection[#title]
  #v(space-content-after-heading, weak: true)
]

#let subsubsection-heading(title) = [
  #v(space-subsubsection, weak: true)
  #text-subsubsection[#title]
  #v(space-xs, weak: true)
]

#let content-nested(body) = block(
  inset: (left: indent-content-nested),
  spacing: space-content-between-blocks,
)[#body]

// In-body headings and blocks (e.g. accomplishments literature notes).
#let content-heading(title) = [
  #v(space-md, weak: true)
  #text-content-heading[#title]
  #v(space-content-after-heading, weak: true)
]

#let content-paragraph(body) = block(
  spacing: space-content-between-blocks,
  below: space-xs,
)[#body]

#let content-equation(body) = block(
  spacing: space-sm,
  above: space-xs,
  below: space-sm,
)[#body]
