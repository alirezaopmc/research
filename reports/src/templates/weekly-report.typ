// Weekly report template: document shell + exported section helpers.
// Instances do: #import "../templates/weekly-report.typ": *
//               #show: weekly-report.with(period: ..., project: ...)
#import "../lib/content.typ": load-labels
#import "../lib/design/layout.typ": setup-document
#import "../lib/date-format.typ": format-short-date
#import "../lib/report-state.typ": *
#import "../lib/components/header-band.typ": header-band
#import "../lib/components/front-page.typ": front-page
#import "../lib/components/detail-page.typ": detail-page

#let labels = load-labels()

// Section helpers (labels pre-bound). Store content; rendered after instance body runs.
#let tldr(body) = store-tldr(body)

#let highlights(..items) = store-highlights(..items)

#let accomplishments(research: [], implementation: [], writing: []) = (
  store-accomplishments(research, implementation, writing)
)

#let challenges(technical: (), theoretical: ()) = (
  store-challenges(technical, theoretical)
)

#let goals(body) = store-goals(body)

#let has-detail-content(sections) = (
  sections.accomplishments != none
    or sections.challenges != none
    or sections.goals != none
)

// Document shell. Applied via `#show: weekly-report.with(...)`.
#let weekly-report(
  period: "",
  project: "",
  number: none,
  researcher: none,
  position: none,
  university: none,
  faculty: none,
  department: none,
  date-short: none,
  body,
) = {
  let name = if researcher != none { researcher } else { labels.researcher }
  let role = if position != none { position } else { labels.position }
  let uni = if university != none { university } else { labels.university }
  let fac = if faculty != none { faculty } else { labels.faculty }
  let dept = if department != none { department } else { labels.department }
  let short-date = if date-short != none {
    date-short
  } else {
    format-short-date(period)
  }

  setup-document(
    page-header-title: labels.title,
  )[
    #body
    #context {
      let sections = report-sections.final()
      [
        #header-band(
          labels, name, role, uni, fac, dept, period, project, number,
          date-short: short-date,
        )
        #front-page(labels, sections)
        #if has-detail-content(sections) [
          #pagebreak()
          #detail-page(labels, sections)
        ]
      ]
    }
  ]
}
