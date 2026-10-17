// Subsection heading (۴-۱، ۴-۲) — typography only, no box.
#import "../../design/typography.typ": text-base-heading

// Sticky so the heading never sits alone at the bottom of a page.
#let body-subsection-heading(section-number, title) = block(sticky: true)[
  #text-base-heading(section-number + " " + title)
  #v(0.5em)
]
