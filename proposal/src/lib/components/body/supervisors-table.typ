// Section 2: supervisors and advisors table.
#import "../../design/typography.typ": text-base-body
#import "../../presenters/body.typ": supervisor-role-label, supervisor-visible-rows
#import "../shared/data-table.typ": form-data-table, registry-header-cell, signature-placeholder-box
#import "section-heading.typ": body-section-heading

// Every supervisor cell is centered; justification is off so short labels do not spread.
#let supervisor-cell(body) = align(center + horizon)[
  #set par(justify: false)
  #text-base-body(body)
]

#let supervisor-signature-cell(signature) = {
  if type(signature) == str and signature.len() == 0 {
    signature-placeholder-box(text-label: "[محل امضا]")
  } else if type(signature) == str and signature.starts-with("[") {
    signature-placeholder-box(text-label: signature)
  } else {
    supervisor-cell(signature)
  }
}

#let body-supervisors-table(labels, meta) = {
  let rows = supervisor-visible-rows(meta.supervisors.rows)
  [
    #body-section-heading("۲", labels.section-supervisors)
    #form-data-table(
      (1.2fr, 1.15fr, 1.1fr, 0.9fr, 1.05fr, 0.9fr),
      rows.map(row => (
        supervisor-cell(supervisor-role-label(labels, row.role)),
        supervisor-cell(row.name),
        supervisor-cell(row.rank),
        supervisor-cell(row.share),
        supervisor-cell(row.workplace),
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
