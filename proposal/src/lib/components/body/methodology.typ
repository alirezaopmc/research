#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-base-label
#import "../shared/tech-footnote.typ": rich-text
#import "figures/methodology-stages.typ": methodology-stages-figure
#import "figures/causal-steering.typ": steering-figure
#import "subsection-heading.typ": body-subheading, body-subsection-heading

#let methodology-bullet-item(item) = {
  rich-text(item)
}

#let methodology-bullet-list(items) = {
  set list(indent: 1.2em, spacing: space-stack-tight)
  list(..items.map(methodology-bullet-item))
}

#let methodology-subsection(number, title, items) = [
  #body-subheading(number, title)
  #methodology-bullet-list(items)
  #v(space-sm)
]

#let methodology-dimensions-block(number, title, labels, dimensions) = [
  #body-subheading(number, title)
  #for item in dimensions [
    #let item-label = labels.at(item.key, default: item.key)
    #par[
      #text-base-label(item-label + ": ")
      #rich-text(item.placeholder)
    ]
    #v(space-stack-tight)
  ]
  #v(space-sm)
]

#let body-methodology-section(labels, meta) = [
  #v(space-md)
  #body-subsection-heading("۴-۲", labels.section-methodology)
  #par(rich-text(meta.methodology.intro))
  #if "resources" in meta.methodology and meta.methodology.resources != none [
    #v(space-xs)
    #par(rich-text(meta.methodology.resources))
  ]
  #if "note" in meta.methodology and meta.methodology.note != none [
    #v(space-xs)
    #par(rich-text(meta.methodology.note))
  ]
  #methodology-stages-figure(meta.figures.methodology-stages)
  #v(space-sm)
  #methodology-subsection("۴-۲-۱", labels.methodology-theory-title, meta.methodology.theory)
  #methodology-subsection("۴-۲-۲", labels.methodology-implementation-title, meta.methodology.implementation)
  #if "dimensions" in meta.methodology and meta.methodology.dimensions != none [
    #methodology-dimensions-block("۴-۲-۳", labels.methodology-dimensions-title, labels, meta.methodology.dimensions)
  ]
  #steering-figure(meta.figures.causal-steering)
]
