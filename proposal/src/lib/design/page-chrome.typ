// Running page header (title + rule) and footer (page number + rule + footnotes).
#import "tokens.typ": *
#import "typography.typ": text-footnote, text-page-header, text-page-number

#let page-rule() = line(length: 100%, stroke: stroke-page-rule + black)

#let page-header-block(title) = [
  #align(left)[
    #text-page-header(title)
    #v(space-header-rule)
    #page-rule()
  ]
]

#let page-footer-block() = context [
  #align(left)[
    #text-page-number(counter(page).display("1"))
    #v(space-footer-rule)
    #page-rule()
  ]
]

#let footnote-entry-block(it) = {
  let loc = it.note.location()
  text-footnote[
    #grid(
      columns: (auto, 1fr),
      column-gutter: 0.35em,
      align: start,
      numbering("1", ..counter(footnote).at(loc)),
      it.note.body
    )
  ]
}

// Apply to content pages (not cover). Cover uses page(header: none, footer: none).
#let apply-page-chrome(title) = {
  set page(
    header: page-header-block(title),
    header-ascent: header-ascent-page,
    footer: page-footer-block(),
    footer-descent: footer-descent-page,
    numbering: none,
  )

  set footnote.entry(
    separator: [
      #v(space-footer-notes)
    ],
    gap: space-footnote-gap,
    indent: 0pt,
  )

  show footnote.entry: footnote-entry-block
}
