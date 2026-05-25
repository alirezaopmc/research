// Layout primitives: RTL-safe centering and per-page shells.
#import "tokens.typ": *
#import "page-chrome.typ": apply-page-chrome

// Full-width box + center align (needed for RTL cover centering).
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

// Cover uses its own page() margins; disables justification.
#let cover-page-shell(body) = page(
  margin: margin-cover,
  header: none,
  footer: none,
)[
  #set align(center)
  #set par(justify: false)
  #body
]

// Letter inherits outer page setup; RTL right-aligned blocks.
#let letter-page-shell(body, page-header-title: none) = [
  #if page-header-title != none {
    apply-page-chrome(page-header-title)
  }
  #set align(right)
  #set par(justify: true)
  #body
]
