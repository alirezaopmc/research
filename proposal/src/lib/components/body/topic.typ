// Section 4: thesis topic details with sub-headings.
#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-base-body, text-base-heading
#import "section-heading.typ": body-section-heading

#let topic-subheading(title) = [
  #v(space-sm)
  #text-base-heading("# " + title)
  #v(space-xs)
]

#let topic-block(title, content) = [
  #topic-subheading(title)
  #par(text-base-body(content))
]

#let body-topic-section(labels, meta) = [
  #body-section-heading("۴", labels.section-topic)
  #text-base-heading("۴.۱. " + labels.section-topic-problem)
  #topic-block(labels.topic-definition, meta.topic.definition)
  #topic-block(labels.topic-goal, meta.topic.goal)
  #topic-block(labels.topic-necessity, meta.topic.necessity)
  #topic-block(labels.topic-research-questions, meta.topic.research-questions)
]
