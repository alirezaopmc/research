// Running page chrome — minimal header/footer, white page.
// Exposed as settings so the caller applies them at document scope
// (set rules inside a function body do not reach the page).
#import "tokens.typ": *
#import "typography.typ": text-footnote, text-page-header, text-page-number
#import "../components/shared.typ": footnote-fa-numbering, plain-text, to-persian-digits

#let persian-script = regex(
  "[\\u{0600}-\\u{06FF}\\u{0750}-\\u{077F}\\u{FB50}-\\u{FDFF}\\u{FE70}-\\u{FEFF}]",
)

// Entry direction follows the first non-space character of the note body.
#let footnote-body-rtl(body) = {
  let first = plain-text(body).find(regex("\\S"))
  first != none and first.match(persian-script) != none
}

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
  let num = counter(footnote).at(loc).first()
  let is-rtl = footnote-body-rtl(it.note.body)
  let entry = if is-rtl {
    text(dir: rtl, lang: "fa")[
      #footnote-fa-numbering(num)
      #h(0.35em)
      #it.note.body
    ]
  } else {
    text(dir: ltr, lang: "en", font: font-english)[
      #footnote-fa-numbering(num)
      #h(0.35em)
      #it.note.body
    ]
  }
  // Persian entries start from the right edge, English entries from the left.
  let side = if is-rtl { right } else { left }
  text-footnote[
    #align(side)[
      #par(leading: 0.15em, spacing: 0pt, justify: false)[#entry]
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
