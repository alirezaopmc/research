// Section 4-3 comparison table: two research families, what each shows and cannot show.
#import "../../design/typography.typ": text-base-body
#import "../shared/data-table.typ": form-data-table, registry-header-cell
#import "../shared/figure.typ": body-table

#let background-comparison-table(content) = body-table(
  form-data-table(
    (1.2fr, 1.6fr, 1.6fr),
    content.rows.map(row => (
      text-base-body(row.family),
      text-base-body(row.shows),
      text-base-body(row.limits),
    )),
    header-cells: (
      registry-header-cell(content.headers.family),
      registry-header-cell(content.headers.shows),
      registry-header-cell(content.headers.limits),
    ),
    style: "registry",
  ),
  content.caption,
)
