// Cover form UI — minimal radios and reference boxes.
#import "../design/tokens.typ": *
#import "shared.typ": to-persian-digits

#let radio-circle(selected: false, size: size-radio) = circle(
  radius: size / 2,
  stroke: 0.6pt + black,
  fill: none,
  if selected {
    place(center + horizon, circle(radius: size / 4, fill: black))
  },
)

#let radio-label(label) = box(width: width-cover-option-label)[
  #align(left + horizon)[#label]
]

#let cover-options-grid(
  start-top-label,
  end-top-label,
  start-bottom-label,
  end-bottom-label,
  start-top-selected: false,
  end-top-selected: false,
  start-bottom-selected: false,
  end-bottom-selected: false,
  row-gap: space-stack-tight,
) = grid(
  columns: (
    width-cover-option-label,
    auto,
    width-cover-option-label,
    auto,
  ),
  column-gutter: (gutter-radio, radio-row-gap, gutter-radio),
  row-gutter: row-gap,
  align: horizon,
  radio-label(start-top-label),
  radio-circle(selected: start-top-selected),
  radio-label(end-top-label),
  radio-circle(selected: end-top-selected),
  radio-label(start-bottom-label),
  radio-circle(selected: start-bottom-selected),
  radio-label(end-bottom-label),
  radio-circle(selected: end-bottom-selected),
)

#let three-option-radio-row(
  first-label,
  second-label,
  third-label,
  first-selected: false,
  second-selected: false,
  third-selected: false,
  column-gutter: gutter-radio,
) = grid(
  columns: (auto, auto, auto, auto, auto, auto),
  column-gutter: column-gutter,
  align: horizon,
  radio-label(first-label),
  radio-circle(selected: first-selected),
  radio-label(second-label),
  radio-circle(selected: second-selected),
  radio-label(third-label),
  radio-circle(selected: third-selected),
)

#let reference-boxes(
  number: "",
  count: count-ref-box,
  box-width: width-ref-box,
  box-height: height-ref-box,
) = {
  let digits = if number.len() > 0 {
    number.clusters()
  } else {
    ()
  }
  grid(
    columns: (auto,) + (box-width,) * count,
    column-gutter: gutter-ref-box,
    align: horizon,
    [],
    ..range(count).map(i => {
      let digit = if i < digits.len() { to-persian-digits(digits.at(i)) } else { "" }
      box(
        width: box-width,
        height: box-height,
        stroke: 0.6pt + black,
        inset: (x: 2pt, y: 3pt),
        align(center + horizon)[#digit],
      )
    }),
  )
}
