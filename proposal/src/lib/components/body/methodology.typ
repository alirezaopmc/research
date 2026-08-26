// Section 4-2: methodology.
#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-base-body, text-base-heading
#import "../shared/tech-footnote.typ": render-segments
#import "subsection-heading.typ": body-subsection-heading

#let methodology-bullet-item(item) = {
  if type(item) == dictionary and item.at("segments", default: none) != none {
    render-segments(item.segments)
  } else {
    text-base-body(item)
  }
}

#let methodology-bullet-list(items) = {
  set list(indent: 1.2em, spacing: space-stack-tight)
  list(..items.map(methodology-bullet-item))
}

#let methodology-subsection(title, items) = [
  #text-base-heading(title)
  #v(space-xs)
  #methodology-bullet-list(items)
  #v(space-sm)
]

#let body-methodology-section(labels, meta) = [
  #v(space-md)
  #body-subsection-heading("۴-۲", labels.section-methodology)
  #par(text-base-body(meta.methodology.intro))
  #v(space-sm)
  #methodology-subsection(labels.methodology-theory-title, meta.methodology.theory)
  #methodology-subsection(labels.methodology-implementation-title, meta.methodology.implementation)
]
