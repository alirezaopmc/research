// Section 3 on detail page: goals for next week.
#import "../content-empty.typ": content-empty
#import "section.typ": section-heading

#let goals-section(labels, body, number: "3") = {
  if content-empty(body) { [] } else {
    [
      #section-heading(number, labels.section-goals)
      #body
    ]
  }
}
