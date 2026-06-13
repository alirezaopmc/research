// Numbered section heading + subsection heading primitives.
#import "../design/tokens.typ": *
#import "../design/typography.typ": text-section, text-subsection

#let section-heading(number, title) = [
  #v(space-section, weak: true)
  #text-section[#number. #title]
  #v(space-xs, weak: true)
  #line(length: 100%, stroke: stroke-rule + color-rule)
  #v(space-sm, weak: true)
]

#let subsection-heading(title) = [
  #v(space-subsection, weak: true)
  #text-subsection(title)
  #v(space-xs, weak: true)
]
