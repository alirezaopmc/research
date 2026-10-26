// Section 4-3: background with bilingual footnotes.
#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-base-body
#import "../shared/tech-footnote.typ": rich-text
#import "background-comparison.typ": background-comparison-table
#import "subsection-heading.typ": body-subheading, body-subsection-heading

#let rich-paragraph(content) = {
  if type(content) == str {
    for p in content.split("\n\n") {
      par(text-base-body(p))
    }
  } else {
    par(rich-text(content))
  }
}

#let body-background-section(labels, meta) = [
  #v(space-md)
  #body-subsection-heading("۴-۳", labels.section-background)
  #rich-paragraph(meta.background.intro)
  #v(space-sm)
  #rich-paragraph(meta.background.development)
  #if "tools" in meta.background and meta.background.tools != none [
    #v(space-sm)
    #for paragraph in meta.background.tools [
      #rich-paragraph(paragraph)
    ]
  ]
  #if "note" in meta.background and meta.background.note != none [
    #v(space-xs)
    #par(rich-text(meta.background.note))
  ]
  #if "synthesis" in meta.background and meta.background.synthesis != none [
    #v(space-sm)
    #body-subheading("۴-۳-۱", labels.background-synthesis)
    #for paragraph in meta.background.synthesis.paragraphs [
      #rich-paragraph(paragraph)
    ]
  ]
  #if "comparison" in meta.background and meta.background.comparison != none [
    #v(space-sm)
    #background-comparison-table(meta.background.comparison)
  ]
  #if "research-gap" in meta.background and meta.background.research-gap != none [
    #v(space-sm)
    #body-subheading("۴-۳-۲", labels.background-research-gap)
    #rich-paragraph(meta.background.research-gap)
  ]
]
