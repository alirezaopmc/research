// Cover label/value row.
#import "../../design/typography.typ": text-cover-field-label
#import "../shared.typ": labeled-field, ltr-value

#let cover-field(label, value) = labeled-field(
  label,
  ltr-value(value),
  text-cover-field-label,
)
