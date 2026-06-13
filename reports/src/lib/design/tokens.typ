// Design tokens: single source for fonts, sizes, spacing, page, assets.

// Typography
#let font-body = "New Computer Modern"
#let font-stack = (font-body,)

#let size-body = 11pt
#let size-section = 13pt
#let size-subsection = 11pt
#let size-title = 22pt
#let size-researcher = 12pt
#let size-position = 10.5pt
#let size-meta = 10.5pt
#let size-report-number = 13pt
#let size-report-date = 9pt

#let weight-strong = "bold"
#let weight-regular = "regular"

// Colors
#let color-rule = luma(60%)
#let color-muted = luma(35%)
#let color-accent = rgb("#0b3d91")
#let color-panel-fill = color-accent.lighten(95%)
#let color-panel-border = color-accent.lighten(70%)

// Spacing
#let space-xxs = 0.15em
#let space-xs = 0.25em
#let space-sm = 0.5em
#let space-md = 1em
#let space-lg = 1.5em
#let space-xl = 2em
#let space-section = 1.1em
#let space-subsection = 0.5em

// Challenge entries
#let space-challenge-item-par = 0.45em
#let space-challenge-issue-tried = 0.35em
#let space-challenge-between-items = 0.85em
#let space-challenge-subsection = 1.1em
#let width-challenge-number = 1.45em
#let gutter-challenge-number = 0.55em
#let gutter-challenge-tried = 0.45em
#let width-challenge-label = 5.4em

// Front page panels
#let radius-panel = 0.45em
#let stroke-panel = 0.75pt
#let stroke-panel-accent = 2.5pt
#let space-front-between-panels = 1.25em
#let space-highlight-item = 0.55em
#let gutter-highlights-columns = 1.75em

// Page
#let paper = "a4"
#let margin-page = (x: 2cm, top: 2cm, bottom: 1.8cm)

// Assets. Relative to the component that calls image() (lib/components/),
// so resolution does not depend on the Typst project root.
#let logo-path = "../../../assets/logos/university-of-tehran.png"
#let logo-height = 2.2cm

// Header band
#let stroke-rule = 0.6pt
#let space-band-after = 1.4em
#let space-report-corner = 0.25em

// Page chrome (running header / footer)
#let size-page-header = 9pt
#let size-page-number = 9pt
#let header-ascent-page = 1cm
#let footer-descent-page = 0.9cm
#let space-footer-rule = 0.3em
#let space-header-rule = 0.3em
