// Layout primitives.
#import "tokens.typ": *
#import "page-chrome.typ": apply-page-chrome

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

#let letter-page-shell(body, page-header-title: none) = [
  #if page-header-title != none {
    apply-page-chrome(page-header-title)
  }
  #set align(right)
  #set par(justify: true)
  #body
]
