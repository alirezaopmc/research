#let education() = [
  = Education

  #grid(
    columns: (1fr, auto),
    column-gutter: 1em,
    align: left,
    [
      *Master of Computer Engineering (Algorithms and Computation)*
    ],
    [
      #align(right)[2024 -- Present]
    ],
  )
  University of Tehran

  #v(0.5em)

  #grid(
    columns: (1fr, auto),
    column-gutter: 1em,
    align: left,
    [
      *Bachelor of Computer Engineering*
    ],
    [
      #align(right)[2018 -- 2024]
    ],
  )
  Babol Noshirvani University of Technology \
  #text(fill: gray)[_Final Project: #link("https://github.com/orgs/uuid-disted/repositories", "Distributed UUID Generation System")_]
]

