// A compact glossary panel kept visually separate from the proposal narrative.
#import "../../design/borders.typ": stroke-form-light
#import "../../design/tokens.typ": space-stack-tight
#import "../../design/typography.typ": text-base-body, text-base-heading, text-base-label
#import "../shared.typ": heading-number
#import "../shared/tech-footnote.typ": render-segments, rich-text

#let key-concepts-panel(number, title, entries) = block(
  width: 100%,
  fill: white,
  stroke: stroke-form-light,
  inset: (x: 9pt, y: 7pt),
)[
  #text-base-heading[#heading-number(number) #title]
  #v(0.45em)
  #for (index, entry) in entries.enumerate() [
    // Sticky term keeps each label with its definition across page breaks.
    #block(sticky: true)[
      #par[
        #text-base-label[
          #render-segments(((text: entry.at("term-fa")),))
          #if entry.at("term-en", default: none) != none [
            #if entry.at("term-en-footnote", default: true) [
              #render-segments(((text: "", en: entry.at("term-en")),))
            ]
          ]
        ]
      ]
    ]
    #par(rich-text(entry.at("definition")))
    #if index < entries.len() - 1 [#v(space-stack-tight)]
  ]
]
