// Running page chrome — minimal header/footer, white page.
// Exposed as settings so the caller applies them at document scope
// (set rules inside a function body do not reach the page).
#import "tokens.typ": *
#import "typography.typ": text-footnote, text-page-header, text-page-number
#import "../components/shared.typ": to-persian-digits

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
    #text-page-number(counter(page).display("۱"))
    #v(space-footer-rule)
    #page-rule()
  ]
]

#let footnote-entry-block(it) = {
  let loc = it.note.location()
  text-footnote[
    #par(leading: 0.15em, spacing: 0pt, justify: false)[
      #set text(dir: rtl, lang: "fa")
      #to-persian-digits(counter(footnote).at(loc).first())
      #h(0.35em)
      #it.note.body
    ]
  ]
}

// `set page(..letter-page-settings(title))` at the top of a letter page.
#let letter-page-settings(title) = (
  header: page-header-block(title),
  header-ascent: header-ascent-page,
  footer: page-footer-block(),
  footer-descent: footer-descent-page,
  numbering: none,
  fill: white,
)

// `set footnote.entry(..letter-footnote-entry-settings)` on letter pages.
#let letter-footnote-entry-settings = (
  separator: [#v(space-footer-notes)],
  gap: space-footnote-gap,
  indent: 0pt,
)
