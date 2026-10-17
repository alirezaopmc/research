// Section 4: topic with bilingual footnotes.
#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-base-body, text-base-heading
#import "../shared.typ": to-persian-digits
#import "../shared/tech-footnote.typ": rich-text
#import "figures/definition-layers.typ": definition-layers-figure
#import "figures/necessity-intervention.typ": necessity-intervention-figure
#import "key-concepts.typ": key-concepts-panel
#import "section-heading.typ": body-section-heading
#import "subsection-heading.typ": body-subsection-heading

#let topic-subheading(title) = block(sticky: true)[
  #v(0.35em)
  #text-base-heading(title)
  #v(0.15em)
]

// Plain numbered list, matching the other body subsections (no form-style box).
#let research-questions-block(title, questions) = [
  #topic-subheading(title)
  #set enum(
    numbering: index => to-persian-digits(index) + ")",
    indent: 0pt,
    body-indent: 0.6em,
    spacing: space-stack-relaxed,
  )
  #enum(..questions.map(question => text-base-body(question)))
]

#let topic-block(title, content) = [
  #topic-subheading(title)
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
  #topic-block(labels.topic-definition, meta.topic.definition)
  #definition-layers-figure(meta.figures.definition-layers)
  #key-concepts-panel(labels.topic-key-concepts, meta.topic.key-concepts)
  #topic-block(labels.topic-goal, meta.topic.goal)
  #topic-block(labels.topic-necessity, meta.topic.necessity)
  #necessity-intervention-figure(meta.figures.necessity-intervention)
  #research-questions-block(labels.topic-research-questions, meta.topic.research-questions)
]
