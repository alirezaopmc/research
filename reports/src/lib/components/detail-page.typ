// Page 2+: accomplishments, challenges, and goals.
#import "accomplishments.typ": accomplishments-section
#import "challenges.typ": challenges-section
#import "goals.typ": goals-section

#let detail-page(labels, sections) = {
  let acc = sections.accomplishments
  let ch = sections.challenges
  let gl = sections.goals

  [
    #if acc != none {
      accomplishments-section(
        labels,
        acc.research,
        acc.implementation,
        acc.writing,
        number: "1",
      )
    }
    #if ch != none {
      challenges-section(
        labels,
        ch.technical,
        ch.theoretical,
        number: "2",
      )
    }
    #if gl != none {
      goals-section(labels, gl, number: "3")
    }
  ]
}
