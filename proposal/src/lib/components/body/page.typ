// Body page orchestrator: stacks all form sections.
#import "../../design/tokens.typ": *
#import "../../design/layout.typ": letter-page-shell
#import "../../presenters/body.typ": body-selection
#import "background.typ": body-background-section
#import "bibliography.typ": body-bibliography-section
#import "methodology.typ": body-methodology-section
#import "summary.typ": body-summary-section
#import "supervisors-table.typ": body-supervisors-table
#import "student-info.typ": body-student-info
#import "timeline.typ": body-timeline-section
#import "topic.typ": body-topic-section

#let proposal-body-page(locale) = {
  let labels = locale.labels
  let meta = locale.meta
  let selection = body-selection(meta)

  letter-page-shell(
    [
      #body-summary-section(labels, meta, selection)
      #v(space-lg)
      #body-supervisors-table(labels, meta)
      #v(space-lg)
      #body-student-info(labels, meta)
      #v(space-lg)
      #body-topic-section(labels, meta)
      #body-methodology-section(labels, meta)
      #body-background-section(labels, meta)
      #body-timeline-section(labels, meta)
      #body-bibliography-section(labels, meta)
    ],
    page-header-title: labels.page-header-title,
  )
}
