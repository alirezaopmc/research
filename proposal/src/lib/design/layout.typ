// Layout primitives.
#import "tokens.typ": *
#import "page-chrome.typ": (
  footnote-entry-block, letter-footnote-entry-settings, letter-page-settings,
)
#import "../components/shared.typ": to-persian-digits

#let centered-block(body) = box(
  width: 100%,
  align(center)[#body],
)

#let centered-stack(spacing: space-stack-normal, ..items) = centered-block[
  #stack(
    spacing: spacing,
    dir: ttb,
    ..items,
  )
]

#let cover-page-shell(body) = page(
  margin: margin-cover,
  header: none,
  footer: none,
  fill: white,
)[
  #set align(center)
  #set par(justify: false)
  #body
]

#let letter-page-shell(body, page-header-title) = [
  #set page(..letter-page-settings(page-header-title))
  #set footnote(numbering: to-persian-digits)
  #set footnote.entry(..letter-footnote-entry-settings)
  #show footnote.entry: footnote-entry-block
  #set align(right)
  #set par(justify: true)
  #body
]
