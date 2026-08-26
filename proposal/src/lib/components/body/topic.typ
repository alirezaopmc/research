// Section 4: topic with bilingual footnotes.
#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-base-body, text-base-heading
#import "../shared/tech-footnote.typ": render-segments
#import "section-heading.typ": body-section-heading
#import "subsection-heading.typ": body-subsection-heading

#let topic-subheading(title) = [
  #v(space-sm)
  #text-base-heading(title)
  #v(space-xs)
]

#let topic-block(title, content) = [
  #topic-subheading(title)
  #if type(content) == dictionary and content.at("segments", default: none) != none {
    par(render-segments(content.segments))
  } else {
    par(text-base-body(content))
  }
]

#let body-topic-section(labels, meta) = [
  #body-section-heading("۴", labels.section-topic)
  #body-subsection-heading("۴-۱", labels.section-topic-problem)
  #topic-block(labels.topic-definition, meta.topic.definition)
  #topic-block(labels.topic-goal, meta.topic.goal)
  #topic-block(labels.topic-necessity, meta.topic.necessity)
  #topic-block(labels.topic-research-questions, meta.topic.research-questions)
]
