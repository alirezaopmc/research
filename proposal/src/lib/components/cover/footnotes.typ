// Cover administrative footnotes (Persian RTL).
#import "../../design/colors.typ": color-ut-blue
#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-cover-section
#import "../shared.typ": to-persian-digits

#let cover-footnote-item(number, body) = [
  #grid(
    columns: (auto, 1fr),
    column-gutter: 0.4em,
    align: start,
    text-cover-section(to-persian-digits(number) + "."),
    text-cover-section(body),
  )
]

#let cover-footnotes(notes) = [
  #v(space-lg)
  #line(length: 100%, stroke: 0.5pt + color-ut-blue)
  #v(space-sm)
  #set align(right)
  #stack(
    spacing: space-stack-tight,
    dir: ttb,
    ..notes.enumerate().map(((i, note)) => cover-footnote-item(i + 1, note)),
  )
]
