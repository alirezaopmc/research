// Global document setup.
#import "design/tokens.typ": font-stack, margin-page, paper, size-body

#let setup-document(
  body,
  size: size-body,
) = {
  set page(paper: paper, margin: margin-page, fill: white)
  set text(lang: "fa", dir: rtl, font: font-stack, size: size)
  set par(leading: 0.65em, spacing: 1.2em)
  body
}
