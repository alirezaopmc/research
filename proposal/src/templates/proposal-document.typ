// Document composer: global setup, cover page, page break, body form sections.
#import "../lib/locale.typ": setup-document
#import "proposal-cover.typ": proposal-cover
#import "proposal-body.typ": proposal-body-content

#let proposal-document(cover-locale, body-locale) = {
  setup-document[
    #proposal-cover(cover-locale)
    #pagebreak()
    #proposal-body-content(body-locale)
  ]
}
