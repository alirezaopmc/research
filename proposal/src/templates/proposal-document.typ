// Document composer: global setup, cover page, body form sections.
// No printed table of contents: the PDF outline (bookmarks) comes from the heading elements.
#import "../lib/locale.typ": setup-document
#import "proposal-cover.typ": proposal-cover
#import "proposal-body.typ": proposal-body-content

#let proposal-document(cover-locale, body-locale) = {
  setup-document[
    // Headings are styled by their own text roles; the heading block itself adds no spacing or weight.
    #show heading: it => it.body
    #proposal-cover(cover-locale)
    #pagebreak()
    #proposal-body-content(body-locale)
  ]
}
