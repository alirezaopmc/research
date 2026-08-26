// Section 3: student information — 2×2 field sheet (no cell grid).
#import "../../design/tokens.typ": space-stack-tight
#import "../../design/typography.typ": text-base-body, text-base-label
#import "../shared.typ": ltr-value
#import "../shared/data-table.typ": form-data-table, signature-placeholder-box
#import "section-heading.typ": body-section-heading

#let student-field-label(label) = text-base-label(label + ":")

#let student-field-value(value) = {
  let body = text-base-body(ltr-value(value))
  let alignment = if type(value) == str and value.len() > 0 and value.match(regex("[a-zA-Z@]")) != none {
    left + top
  } else {
    right + top
  }
  align(alignment)[#body]
}

#let student-field-pair(label, value) = align(right + top)[
  #student-field-label(label)
  #v(space-stack-tight)
  #student-field-value(value)
]

#let student-signature-pair(label, signature) = align(right + top)[
  #student-field-label(label)
  #v(space-stack-tight)
  #if type(signature) == str and signature.len() > 0 {
    student-field-value(signature)
  } else {
    signature-placeholder-box()
  }
]

#let body-student-info(labels, meta) = {
  let student = meta.student
  [
    #body-section-heading("۳", labels.section-student)
    #form-data-table(
      (),
      (
        (
          student-field-pair(labels.student-name, student.name),
          student-field-pair(labels.student-phone, student.phone),
        ),
        (
          student-field-pair(labels.student-degree, student.degree),
          student-field-pair(labels.student-email, student.email),
        ),
        (
          student-field-pair(labels.student-field, student.field),
          student-signature-pair(labels.student-signature, student.signature),
        ),
      ),
      style: "fields",
    )
  ]
}
