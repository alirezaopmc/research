// Numbered section heading for body pages.
#import "../../design/typography.typ": text-base-heading

#let body-section-heading(number, title) = [
  #text-base-heading(number + ". " + title)
  #v(0.5em)
]
