// Page 1 body: TL;DR callout + important-notes list (after header band).
#import "../content-empty.typ": content-empty
#import "../design/tokens.typ": *
#import "../design/typography.typ": text-panel-title, text-tldr-body

#let front-panel(title, body) = box(
  width: 100%,
  inset: (x: space-md, y: space-md),
  radius: radius-panel,
  stroke: (
    top: stroke-panel-accent + color-accent,
    rest: stroke-panel + color-panel-border,
  ),
  fill: color-panel-fill,
  [
    #text-panel-title(title)
    #v(space-sm)
    #body
  ],
)

#let highlight-item(body) = grid(
  columns: (0.55em, 1fr),
  column-gutter: 0.35em,
  align: (left + top, left + top),
  text(fill: color-accent)[#sym.bullet],
  body,
)

#let horizontal-highlight-grid(items) = grid(
  columns: (1fr, 1fr),
  column-gutter: gutter-highlights-columns,
  row-gutter: space-highlight-item,
  align: (left + top, left + top),
  ..items.map(item => highlight-item(item)),
)

#let highlights-section(title, items) = [
  #text-panel-title(title)
  #v(space-sm)
  #horizontal-highlight-grid(items)
]

#let front-page(labels, sections) = {
  let tldr = sections.tldr
  let highlights = sections.highlights
  let has-tldr = tldr != none and not content-empty(tldr)
  let has-highlights = highlights != none and not content-empty(highlights)

  if not has-tldr and not has-highlights { [] } else {
    [
      #if has-tldr [
        #front-panel(labels.section-tldr, text-tldr-body(tldr))
      ]
      #if has-tldr and has-highlights [
        #v(space-front-between-panels)
      ]
      #if has-highlights [
        #highlights-section(labels.section-highlights, highlights)
      ]
    ]
  }
}
