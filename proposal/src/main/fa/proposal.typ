// Entry: loads YAML locales and renders full proposal PDF (cover + body).
#import "../../templates/proposal-document.typ": proposal-document
#import "../../lib/content.typ": load-cover-locale, load-body-locale

#let cover-locale = load-cover-locale()
#let body-locale = load-body-locale()

#show: doc => proposal-document(cover-locale, body-locale)
