// Section 1: thesis summary with title fields and thesis-type radios.
#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-base-label
#import "../shared.typ": labeled-field
#import "../cover-form.typ": three-option-radio-row
#import "section-heading.typ": body-section-heading

#let body-field(label, value) = labeled-field(
  label,
  value,
  text-base-label,
  row-gutter: space-stack-tight,
)

#let body-summary-section(labels, meta, selection) = [
  #body-section-heading("۱", labels.section-summary)
  #body-field(labels.title-fa, meta.summary.title-fa)
  #v(space-stack-tight)
  #body-field(labels.title-en, meta.summary.title-en)
  #v(space-stack-tight)
  #grid(
    columns: (auto, 1fr),
    column-gutter: gutter-field,
    align: horizon,
    text-base-label(labels.thesis-type + ":"),
    three-option-radio-row(
      labels.thesis-type-fundamental,
      labels.thesis-type-applied,
      labels.thesis-type-developmental,
      first-selected: selection.fundamental-selected,
      second-selected: selection.applied-selected,
      third-selected: selection.developmental-selected,
    ),
  )
]
