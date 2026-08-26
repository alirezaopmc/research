// Subsection heading (۴-۱، ۴-۲) — typography only, no box.
#import "../../design/typography.typ": text-base-heading

#let body-subsection-heading(section-number, title) = [
  #text-base-heading(section-number + " " + title)
  #v(0.5em)
]
