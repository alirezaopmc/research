// Cover footer fields (campus entry, reference number boxes).
#import "../../design/tokens.typ": gutter-field, space-stack-normal
#import "../../design/typography.typ": text-cover-section
#import "../cover-form.typ": reference-boxes
#import "field.typ": cover-field

#let cover-footer-fields(labels, meta) = stack(
  spacing: space-stack-normal,
  dir: ttb,
  cover-field(labels.campus-entry, meta.at("campus-entry", default: "")),
  grid(
    columns: (auto, 1fr),
    column-gutter: gutter-field,
    align: horizon,
    text-cover-section(labels.reference-number + ":"),
    reference-boxes(number: meta.at("reference-number", default: "")),
  ),
)
