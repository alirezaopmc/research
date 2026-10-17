// Bibliography — LTR English block inside RTL document.
#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-base-label
#import "../shared.typ": to-persian-digits
#import "../shared/tech-footnote.typ": ltr-block

#let bibliography-entry(number, citation) = [
  #par(
    hanging-indent: 1.4em,
    text(size: size-body)[
      #strong(to-persian-digits(number) + ". ")
      #citation
    ],
  )
  #v(space-stack-tight)
]

#let body-bibliography-section(labels, meta) = [
  #text-base-label(labels.section-bibliography)
  #if "note" in meta.bibliography and meta.bibliography.note != none [
    #v(space-xs)
    #par(text(size: size-body)[#meta.bibliography.note])
  ]
  #v(space-sm)
  #ltr-block[
    #for (i, entry) in meta.bibliography.entries.enumerate() {
      bibliography-entry(i + 1, entry)
    }
  ]
]
