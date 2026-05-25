// Main cover form fields (name, IDs, supervisors, date).
#import "../../design/tokens.typ": space-stack-relaxed
#import "field.typ": cover-field

#let cover-form-fields(labels, meta) = stack(
  spacing: space-stack-relaxed,
  dir: ttb,
  cover-field(labels.name, meta.name),
  cover-field(labels.student-id, meta.student-id),
  cover-field(labels.supervisor, meta.supervisor),
  cover-field(labels.advisor, meta.at("advisor", default: "")),
  cover-field(labels.approval-date, meta.approval-date),
)
