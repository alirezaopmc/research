// Signed build: supervisor images from supervisors.signed.yaml (local, gitignored).
#import "../../templates/proposal-document.typ": proposal-document
#import "../../lib/content.typ": load-cover-locale, load-body-locale-signed

#let cover-locale = load-cover-locale()
#let body-locale = load-body-locale-signed()

#show: doc => proposal-document(cover-locale, body-locale)