// Section 2: supervisors and advisors table.
#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-base-body, text-base-label
#import "../../presenters/body.typ": supervisor-role-label
#import "section-heading.typ": body-section-heading

#let table-stroke = 0.6pt + black
#let table-inset = (x: 6pt, y: 7pt)

#let body-supervisors-table(labels, meta) = {
  let rows = meta.supervisors.rows
  [
    #body-section-heading("۲", labels.section-supervisors)
    #table(
      columns: (1.2fr, 1.2fr, 0.85fr, 0.85fr, 0.95fr, 0.95fr),
      rows: (height-supervisor-table-header,) + (height-supervisor-table-row,) * rows.len(),
      inset: table-inset,
      stroke: table-stroke,
      align: center + horizon,
      table.header(
        align(center + horizon)[#text-base-label(labels.supervisor-col-role)],
        align(center + horizon)[#text-base-label(labels.supervisor-col-name)],
        align(center + horizon)[#text-base-label(labels.supervisor-col-rank)],
        align(center + horizon)[#text-base-label(labels.supervisor-col-share)],
        align(center + horizon)[#text-base-label(labels.supervisor-col-workplace)],
        align(center + horizon)[#text-base-label(labels.supervisor-col-signature)],
        repeat: false,
      ),
      ..rows.map(row => (
        text-base-label(supervisor-role-label(labels, row.role)),
        text-base-body(row.name),
        text-base-body(row.rank),
        text-base-body(row.share),
        text-base-body(row.workplace),
        text-base-body(row.signature),
      )).flatten(),
    )
  ]
}
