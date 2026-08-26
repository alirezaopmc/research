// Section 4-3: background with bilingual footnotes.
#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-base-body
#import "../shared/tech-footnote.typ": render-segments
#import "subsection-heading.typ": body-subsection-heading

#let rich-paragraph(content) = {
  if type(content) == dictionary and content.at("segments", default: none) != none {
    par(render-segments(content.segments))
  } else {
    par(text-base-body(content))
  }
}

#let body-background-section(labels, meta) = [
  #v(space-md)
  #body-subsection-heading("۴-۳", labels.section-background)
  #rich-paragraph(meta.background.intro)
  #v(space-sm)
  #rich-paragraph(meta.background.development)
]
