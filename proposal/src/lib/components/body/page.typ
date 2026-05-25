// Body page orchestrator: stacks all form sections.
#import "../../design/tokens.typ": *
#import "../../design/layout.typ": letter-page-shell
#import "../../presenters/body.typ": body-selection
#import "summary.typ": body-summary-section
#import "supervisors-table.typ": body-supervisors-table
#import "student-info.typ": body-student-info
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
    ],
    page-header-title: labels.page-header-title,
  )
}
