// Section: challenges & blockers (subsections + numbered items).
#import "../content-empty.typ": content-empty
#import "../design/tokens.typ": *
#import "../design/typography.typ": text-challenge-detail, text-meta-label
#import "section.typ": section-heading, subsection-heading

#let normalize-technical(technical) = {
  if technical == none or technical == () { return () }
  if type(technical) == dictionary and "issue" in technical.keys() {
    return (technical,)
  }
  if type(technical) == array { return technical }
  ()
}

#let normalize-theoretical(theoretical) = {
  if theoretical == none or theoretical == () { return () }
  if type(theoretical) == array { return theoretical }
  if content-empty(theoretical) { () } else { (theoretical,) }
}

#let technical-item-empty(item) = (
  content-empty(item.at("issue", default: []))
    and content-empty(item.at("tried", default: none))
)

#let challenge-item-content(body) = block(
  spacing: 0pt,
  breakable: true,
  {
    set par(
      spacing: space-challenge-item-par,
      leading: 0.62em,
      justify: true,
    )
    body
  },
)

#let challenge-labeled-row(label, body) = grid(
  columns: (width-challenge-label, 1fr),
  column-gutter: gutter-challenge-tried,
  align: (left + top, left + top),
  text-meta-label[#label:],
  text-challenge-detail(body),
)

#let technical-item-body(labels, item) = {
  let issue = item.at("issue", default: [])
  let tried = item.at("tried", default: none)
  challenge-item-content[
    #if not content-empty(issue) [
      #challenge-labeled-row(labels.challenges-issue, issue)
    ]
    #if not content-empty(tried) [
      #v(space-challenge-issue-tried, weak: true)
      #challenge-labeled-row(labels.challenges-tried, tried)
    ]
  ]
}

#let theoretical-item-body(item) = challenge-item-content(item)

#let challenge-numbered-item(number, body) = grid(
  columns: (width-challenge-number, 1fr),
  column-gutter: gutter-challenge-number,
  align: (right + top, left + top),
  text(size: size-body, weight: weight-strong, fill: color-accent)[#number.],
  body,
)

#let challenge-list(items, item-body) = {
  if items.len() == 0 { [] } else {
    for (i, item) in items.enumerate() [
      #challenge-numbered-item(i + 1, item-body(item))
      #if i < items.len() - 1 [
        #v(space-challenge-between-items, weak: true)
      ]
    ]
  }
}

#let challenge-subsection(title, items, item-body) = {
  if items.len() == 0 { [] } else {
    [
      #subsection-heading(title)
      #challenge-list(items, item-body)
    ]
  }
}

#let challenges-section(labels, technical, theoretical, number: "2") = {
  let tech-items = normalize-technical(technical)
    .filter(item => not technical-item-empty(item))
  let theory-items = normalize-theoretical(theoretical)
    .filter(item => not content-empty(item))

  if tech-items.len() == 0 and theory-items.len() == 0 { [] } else {
    [
      #section-heading(number, labels.section-challenges)
      #challenge-subsection(
        labels.challenges-technical,
        tech-items,
        item => technical-item-body(labels, item),
      )
      #if tech-items.len() > 0 and theory-items.len() > 0 [
        #v(space-challenge-subsection, weak: true)
      ]
      #challenge-subsection(
        labels.challenges-theoretical,
        theory-items,
        theoretical-item-body,
      )
    ]
  }
}
