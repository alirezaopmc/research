// Cover degree + study-mode options (single grid for column alignment).
#import "../../design/cover-spacing.typ": cover-spacing
#import "../../design/layout.typ": centered-block
#import "../cover-form.typ": cover-options-grid

#let cover-options-block(labels, selection) = {
  let row-gap = cover-spacing.options.at("between-rows")
  centered-block[
    #cover-options-grid(
      labels.degree-masters,
      labels.degree-phd,
      labels.study-mode-day,
      labels.study-mode-evening,
      start-top-selected: selection.masters-selected,
      end-top-selected: selection.phd-selected,
      start-bottom-selected: selection.day-selected,
      end-bottom-selected: selection.evening-selected,
      row-gap: row-gap,
    )
  ]
}
