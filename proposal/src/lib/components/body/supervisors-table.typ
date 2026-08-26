// Section 2: supervisors and advisors table.
#import "../../design/typography.typ": text-base-body
#import "../../presenters/body.typ": supervisor-role-label
#import "../shared/data-table.typ": form-data-table, registry-header-cell, signature-placeholder-box
#import "section-heading.typ": body-section-heading

#let supervisor-text-cell(body) = align(right + top)[#text-base-body(body)]
#let supervisor-short-cell(body) = align(center + horizon)[#text-base-body(body)]

#let supervisor-signature-cell(signature) = {
  if type(signature) == str and signature.len() == 0 {
    signature-placeholder-box()
  } else {
    supervisor-short-cell(signature)
  }
}

#let body-supervisors-table(labels, meta) = {
  let rows = meta.supervisors.rows
  [
    #body-section-heading("۲", labels.section-supervisors)
    #form-data-table(
      (1.2fr, 1.15fr, 0.75fr, 0.95fr, 1.05fr, 0.95fr),
      rows.map(row => (
        supervisor-text-cell(supervisor-role-label(labels, row.role)),
        supervisor-text-cell(row.name),
        supervisor-short-cell(row.rank),
        supervisor-short-cell(row.share),
        supervisor-text-cell(row.workplace),
        supervisor-signature-cell(row.signature),
      )),
      header-cells: (
        registry-header-cell(labels.supervisor-col-role),
        registry-header-cell(labels.supervisor-col-name),
        registry-header-cell(labels.supervisor-col-rank),
        registry-header-cell(labels.supervisor-col-share),
        registry-header-cell(labels.supervisor-col-workplace),
        registry-header-cell(labels.supervisor-col-signature),
      ),
      style: "registry",
    )
  ]
}
