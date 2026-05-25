// Cover-only entry: fast iteration on cover page layout.
#import "../../lib/locale.typ": setup-document
#import "../../lib/content.typ": load-cover-locale
#import "../../templates/proposal-cover.typ": proposal-cover

#show: setup-document(proposal-cover(load-cover-locale()))
