// Branded header band: logo + title + researcher/position + meta grid.
#import "../design/tokens.typ": *
#import "../design/typography.typ": (
  text-affiliation, text-meta-label, text-meta-value, text-position,
  text-report-date, text-report-number, text-researcher, text-title, text-university,
)

#let meta-row(label, value) = [
  #text-meta-label[#label:]#h(0.4em)#text-meta-value(value)
]

#let report-badge(number) = box(
  inset: (x: 0.55em, y: 0.35em),
  radius: 0.35em,
  stroke: stroke-rule + color-accent,
  text-report-number("#" + str(number)),
)

#let report-corner(date-short, number) = align(right)[
  #if date-short != none and date-short != "" [
    #text-report-date(date-short)
    #v(space-report-corner)
  ]
  #if number != none {
    report-badge(number)
  }
]

#let header-band(
  labels,
  researcher,
  position,
  university,
  faculty,
  department,
  period,
  project,
  number,
  date-short: none,
) = [
  #if number != none or (date-short != none and date-short != "") {
    place(top + right, report-corner(date-short, number))
  }
  #align(center)[
    #image(logo-path, height: logo-height)
    #v(space-sm)
    #text-university(university)
    #v(space-xxs)
    #text-affiliation(faculty)
    #v(space-xxs)
    #text-affiliation(department)
    #v(space-sm)
    #text-title(labels.title)
    #v(space-sm)
    #text-researcher(researcher)
    #v(space-xxs)
    #text-position(position)
  ]
  #v(space-sm)
  #line(length: 100%, stroke: stroke-rule + color-rule)
  #v(space-xs)
  #grid(
    columns: (1fr, auto),
    align: (left, right),
    meta-row(labels.meta-project, project),
    meta-row(labels.meta-period, period),
  )
  #v(space-xs)
  #line(length: 100%, stroke: stroke-rule + color-rule)
  #v(space-band-after)
]
