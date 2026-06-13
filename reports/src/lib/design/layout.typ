// Global document setup: page size, LTR English, font stack, page chrome.
#import "tokens.typ": *
#import "page-chrome.typ": apply-page-chrome

#let setup-document(body, page-header-title: none) = {
  set page(paper: paper, margin: margin-page)
  set text(lang: "en", dir: ltr, font: font-stack, size: size-body)
  set par(leading: 0.62em, spacing: 1em, justify: true)
  set list(indent: 0.6em, spacing: 0.6em)

  if page-header-title != none {
    apply-page-chrome(page-header-title)
  }
  body
}
