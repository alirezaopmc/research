// Collect report sections from instance helpers, then render front + detail pages.

#let report-sections = state("report-sections", (
  tldr: none,
  highlights: none,
  accomplishments: none,
  challenges: none,
  goals: none,
))

#let store-tldr(body) = {
  report-sections.update(p => (..p, tldr: body))
  []
}

#let store-highlights(..items) = {
  report-sections.update(p => (..p, highlights: items.pos()))
  []
}

#let store-accomplishments(research, implementation, writing) = {
  report-sections.update(p => (..p, accomplishments: (
    research: research,
    implementation: implementation,
    writing: writing,
  )))
  []
}

#let store-challenges(technical, theoretical) = {
  report-sections.update(p => (..p, challenges: (
    technical: technical,
    theoretical: theoretical,
  )))
  []
}

#let store-goals(body) = {
  report-sections.update(p => (..p, goals: body))
  []
}
