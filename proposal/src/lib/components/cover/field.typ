// Cover label/value row.
#import "../../design/typography.typ": text-cover-field-label
#import "../shared.typ": labeled-field

#let cover-field(label, value) = labeled-field(
  label,
  value,
  text-cover-field-label,
)
