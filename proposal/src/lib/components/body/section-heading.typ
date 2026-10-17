// Numbered section heading.
#import "../../design/typography.typ": text-base-heading

// Sticky so the heading never sits alone at the bottom of a page.
#let body-section-heading(number, title) = block(sticky: true)[
  #text-base-heading(number + ". " + title)
  #v(0.5em)
]
