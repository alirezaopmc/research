// Cover masthead — official layout: invocation, dual logos.
#import "../../design/tokens.typ": *
#import "../../design/typography.typ": text-cover-section

#let logo-faculty = "../../../../assets/logos/faculty-of-engineering.png"
#let logo-ut = "../../../../assets/logos/university-of-tehran.png"
#let logo-height-header = 2.2cm

#let cover-header(invocation: "بنام خدا") = [
  #text-cover-section(invocation)
  #v(space-sm)
  #grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 0.5em,
    align: (left + horizon, center + horizon, right + horizon),
    image(logo-faculty, height: logo-height-header),
    [],
    image(logo-ut, height: logo-height-header),
  )
  #v(space-md)
]
