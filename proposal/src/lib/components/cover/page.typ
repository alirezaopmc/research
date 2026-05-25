// Cover page orchestrator: stacks visual sections from locale.
#import "../../design/layout.typ": centered-stack, cover-page-shell
#import "../../presenters/cover.typ": cover-selection
#import "footer-fields.typ": cover-footer-fields
#import "form-fields.typ": cover-form-fields
#import "logo.typ": cover-logo
#import "options.typ": cover-options-block
#import "organization.typ": cover-organization
#import "panel.typ": cover-form-panel
#import "spacing.typ": cover-section
#import "title.typ": cover-title

#let proposal-cover-page(locale) = {
  let labels = locale.labels
  let meta = locale.meta
  let selection = cover-selection(meta)

  cover-page-shell[
    #centered-stack(
      spacing: 0em,
      cover-section("logo", cover-logo()),
      cover-section("organization", cover-organization(meta)),
      cover-section("title", cover-title(labels)),
      cover-section("options", cover-options-block(labels, selection)),
      cover-section("form", cover-form-panel(cover-form-fields(labels, meta))),
      cover-section("footer", cover-form-panel(cover-footer-fields(labels, meta))),
    )
  ]
}
