// Section 3: student information as single-column fields.
#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-base-label
#import "../shared.typ": labeled-field
#import "section-heading.typ": body-section-heading

#let student-field(label, value) = labeled-field(
  label,
  if value.len() > 0 { value } else { [] },
  text-base-label,
  row-gutter: space-stack-tight,
)

#let body-student-info(labels, meta) = {
  let student = meta.student
  [
    #body-section-heading("۳", labels.section-student)
    #student-field(labels.student-name, student.name)
    #v(space-stack-tight)
    #student-field(labels.student-phone, student.phone)
    #v(space-stack-tight)
    #student-field(labels.student-degree, student.degree)
    #v(space-stack-tight)
    #student-field(labels.student-email, student.email)
    #v(space-stack-tight)
    #student-field(labels.student-field, student.field)
    #v(space-stack-tight)
    #student-field(labels.student-signature, student.signature)
  ]
}
