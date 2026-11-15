// Numbered section heading (۱.، ۲.، …).
#import "heading.typ": body-heading

// Sticky so the heading never sits alone at the bottom of a page.
#let body-section-heading(number, title) = block(sticky: true)[
  #body-heading(1, number, title)
  #v(0.5em)
]
