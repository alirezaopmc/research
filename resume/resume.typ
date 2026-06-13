#set page(
  paper: "a4",
  margin: (x: 1in, y: 1in),
)

#set text(size: 10pt)
#set par(leading: 0.65em)

#import "sections/about_me.typ": *
#import "sections/experience.typ": *
#import "sections/education.typ": *
#import "sections/projects.typ": *
#import "sections/awards.typ": *
#import "sections/certifications.typ": *
#import "sections/skills.typ": *
#import "sections/languages.typ": *

#grid(
  columns: (1fr, 1fr),
  column-gutter: 0.5em,
  align: horizon,
  [
    *Alireza Jafartash* \
    Software Engineer \
    #link("https://github.com/alirezaopmc", "Github") — #link("https://linkedin.com/in/alirezaopmc", "LinkedIn")
  ],
  [
    #align(right, [
      #link("mailto:jtash@ut.ac.ir", "jtash@ut.ac.ir") \
      #link("mailto:alirezaopmc@gmail.com", "alirezaopmc@gmail.com") \
      #link("tel:+989388727940", "+98 938 872 7940")
    ])
  ]
)

#line(length: 100%, stroke: 0.3pt)
#v(0.5em)

#about-me()
#experience()
#education()
#projects()
#awards()
#certifications()
#skills()
#languages()
