// Shared UI primitives used by cover and letter.
#import "../design/tokens.typ": gutter-field

#let labeled-field(label, value, label-style, row-gutter: 0em) = {
  grid(
    columns: (auto, 1fr),
    column-gutter: gutter-field,
    row-gutter: row-gutter,
    align: horizon,
    label-style(label + ":"),
    value,
  )
}
