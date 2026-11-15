// Subsection headings (۴-۱.، ۴-۲.) and level-3 headings (۴-۱-۱.): typography only, no box.
#import "heading.typ": body-heading

// Sticky so the heading never sits alone at the bottom of a page.
#let body-subsection-heading(section-number, title) = block(sticky: true)[
  #body-heading(2, section-number, title)
  #v(0.5em)
]

// Level 3 uses the same weight as level 2 with tighter spacing, so it reads as a child heading.
#let body-subheading(number, title) = block(sticky: true)[
  #v(0.35em)
  #body-heading(3, number, title)
  #v(0.15em)
]
