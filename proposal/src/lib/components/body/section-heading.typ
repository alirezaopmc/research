// Numbered section heading (۱.، ۲.، …).
#import "../../design/typography.typ": text-base-heading
#import "../shared.typ": heading-number

// Sticky so the heading never sits alone at the bottom of a page.
#let body-section-heading(number, title) = block(sticky: true)[
  #text-base-heading[#heading-number(number) #title]
  #v(0.5em)
]
