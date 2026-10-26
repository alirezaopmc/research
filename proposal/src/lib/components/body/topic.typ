// Section 4: topic with bilingual footnotes.
#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-base-body
#import "../shared.typ": to-persian-digits
#import "../shared/tech-footnote.typ": rich-text
#import "figures/definition-layers.typ": definition-layers-figure
#import "figures/necessity-intervention.typ": necessity-intervention-figure
#import "key-concepts.typ": key-concepts-panel
#import "section-heading.typ": body-section-heading
#import "subsection-heading.typ": body-subheading, body-subsection-heading

// Plain numbered list, matching the other body subsections (no form-style box).
#let research-questions-block(number, title, questions) = [
  #body-subheading(number, title)
  #set enum(
    numbering: index => to-persian-digits(index) + ")",
    indent: 0pt,
    body-indent: 0.6em,
    spacing: space-stack-relaxed,
  )
  #enum(..questions.map(question => rich-text(question)))
]

#let topic-block(number, title, content) = [
  #body-subheading(number, title)
  #if type(content) == dictionary {
    if content.at("segments", default: none) != none {
      par(rich-text(content))
    }
    if content.at("paragraphs", default: none) != none {
      for paragraph in content.paragraphs {
        if type(paragraph) == dictionary {
          if paragraph.at("segments", default: none) != none {
            par(rich-text(paragraph))
          } else {
            par(text-base-body(paragraph.at("text", default: "")))
          }
        } else {
          par(text-base-body(paragraph))
        }
      }
    }
    if content.at("text", default: none) != none {
      par(text-base-body(content.text))
    }
    if content.at("note", default: none) != none {
      v(space-xs)
      par(text-base-body(content.note))
    }
  } else if type(content) == str {
    for p in content.split("\n\n") {
      par(text-base-body(p))
    }
  } else {
    par(text-base-body(content))
  }
]

#let body-topic-section(labels, meta) = [
  #body-section-heading("۴", labels.section-topic)
  #body-subsection-heading("۴-۱", labels.section-topic-problem)
  #topic-block("۴-۱-۱", labels.topic-definition, meta.topic.definition)
  #definition-layers-figure(meta.figures.definition-layers)
  #key-concepts-panel("۴-۱-۲", labels.topic-key-concepts, meta.topic.key-concepts)
  #topic-block("۴-۱-۳", labels.topic-goal, meta.topic.goal)
  #topic-block("۴-۱-۴", labels.topic-necessity, meta.topic.necessity)
  #necessity-intervention-figure(meta.figures.necessity-intervention)
  #research-questions-block("۴-۱-۵", labels.topic-research-questions, meta.topic.research-questions)
]
