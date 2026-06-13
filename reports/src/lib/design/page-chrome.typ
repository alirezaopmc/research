// Running page header (report title) and footer (page number + rule).
#import "tokens.typ": *
#import "typography.typ": text-page-header, text-page-number

#let page-rule() = line(length: 100%, stroke: stroke-rule + color-rule)

#let page-header-block(title) = context {
  // No running header on the first page (header band already shows the title).
  if counter(page).get().first() > 1 [
    #grid(
      columns: (1fr, auto),
      text-page-header(title),
      text-page-header(""),
    )
    #v(space-header-rule)
    #page-rule()
  ]
}

#let page-footer-block() = context [
  #page-rule()
  #v(space-footer-rule)
  #align(center)[
    #text-page-number(counter(page).display("1 / 1", both: true))
  ]
]

#let apply-page-chrome(title) = {
  set page(
    header: page-header-block(title),
    header-ascent: header-ascent-page,
    footer: page-footer-block(),
    footer-descent: footer-descent-page,
    numbering: "1",
  )
}
