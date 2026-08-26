// Form tables: grid (timeline), registry (§2), fields (§3).
#import "../../design/colors.typ": color-ut-blue
#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-base-label

#let form-table-stroke-grid = 0.6pt + color-ut-blue
#let form-table-stroke-registry-edge = 0.35pt + color-ut-blue
#let form-table-stroke-registry-header = 1pt + color-ut-blue
#let form-table-stroke-registry-row = 0.35pt + color-ut-blue
#let form-table-stroke-signature = (
  thickness: 0.4pt,
  paint: color-ut-blue,
  dash: "dashed",
)

#let form-table-inset-grid = (x: 6pt, y: 8pt)
#let form-table-inset-registry = (x: 6pt, y: 10pt)
#let form-table-inset-fields = (x: 6pt, y: 10pt)

#let horizontal-stroke(total-rows, header-count, header-bottom) = (x, y) => {
  let top = if y == 0 { form-table-stroke-registry-edge } else { none }
  let bottom = if header-count > 0 and y == 0 {
    header-bottom
  } else {
    form-table-stroke-registry-row
  }
  (top: top, bottom: bottom, left: none, right: none)
}

#let registry-table-stroke(total-rows, header-count) = horizontal-stroke(
  total-rows,
  header-count,
  form-table-stroke-registry-header,
)

#let fields-table-stroke(total-rows) = horizontal-stroke(total-rows, 0, none)

#let registry-header-cell(label) = align(center + horizon)[
  #text(
    fill: color-ut-blue,
    hyphenate: false,
  )[#text-base-label(label.replace(" ", sym.space.nobreak))]
]

#let signature-placeholder-box() = align(center + horizon)[
  #box(width: 100%, height: 0.9cm, stroke: form-table-stroke-signature)
]

#let form-fields-sheet(rows) = {
  table(
    columns: (1fr, 1fr),
    rows: (auto,) * rows.len(),
    inset: form-table-inset-fields,
    stroke: fields-table-stroke(rows.len()),
    align: right + top,
    fill: (_, _) => white,
    ..rows.map(row => (row.at(0), row.at(1))).flatten(),
  )
}

#let form-data-table(
  columns,
  rows,
  header-cells: (),
  row-heights: none,
  align: right + top,
  style: "grid",
) = {
  if style == "fields" {
    form-fields-sheet(rows)
  } else {
    let header-count = if header-cells.len() > 0 { 1 } else { 0 }
    let total-rows = header-count + rows.len()
    let heights = if row-heights != none {
      row-heights
    } else {
      (auto,) * total-rows
    }
    let header-row = if header-count > 0 {
      (table.header(..header-cells, repeat: false),)
    } else {
      ()
    }
    let inset = if style == "registry" { form-table-inset-registry } else { form-table-inset-grid }
    let stroke = if style == "registry" {
      registry-table-stroke(total-rows, header-count)
    } else {
      form-table-stroke-grid
    }
    let table-align = if style == "grid" and align == right + top {
      center + horizon
    } else {
      align
    }

    table(
      columns: columns,
      rows: heights,
      inset: inset,
      stroke: stroke,
      align: table-align,
      fill: (_, _) => white,
      ..header-row,
      ..rows.flatten(),
    )
  }
}
