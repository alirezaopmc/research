// Timeline — phase list + month grid.
#import "../../design/colors.typ": color-ut-blue
#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-base-body, text-base-label
#import "../shared.typ": to-persian-digits
#import "../shared/data-table.typ": form-data-table

#let phase-label(n) = "مرحله " + (
  ("اول", "دوم", "سوم", "چهارم", "پنجم", "ششم").at(
    calc.min(n - 1, 5),
    default: to-persian-digits(n),
  )
)

#let timeline-phase-list(phases) = {
  set list(indent: 1.2em, spacing: space-stack-tight)
  list(..phases.enumerate().map(((i, phase)) => text-base-body(
    phase-label(i + 1) + ": " + phase,
  )))
}

#let month-active(months, active-months) = months.map(month => {
  align(center + horizon)[
    #if active-months.contains(str(month)) {
      box(width: 100%, height: 0.5cm, stroke: 0.4pt + color-ut-blue)
    }
  ]
})

#let timeline-grid(months, phases) = {
  let month-cells = months.map(m => align(center + horizon)[#text-base-label(to-persian-digits(m))])
  let phase-rows = phases.map(phase => {
    let cells = month-active(months, phase.months)
    (
      align(center + horizon)[#text-base-label(phase.label)],
      ..cells,
    )
  })
  form-data-table(
    (1.4fr,) + (0.45fr,) * months.len(),
    phase-rows,
    header-cells: (
      align(center + horizon)[#text-base-label("فاز")],
      ..month-cells,
    ),
    style: "grid",
    align: center + horizon,
  )
}

#let body-timeline-section(labels, meta) = [
  #v(space-md)
  #text-base-label(labels.section-timeline)
  #v(space-sm)
  #timeline-phase-list(meta.timeline.phases)
  #v(space-md)
  #timeline-grid(meta.timeline.months, meta.timeline.schedule)
]
