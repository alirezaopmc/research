// Design tokens: single source for fonts, sizes, spacing, page, assets.
// Paths are relative to this file (lib/design/).

// Typography
#let font-persian = "XB Niloofar"
#let font-english = "New Computer Modern"
#let font-stack = (font-english, font-persian)

#let size-body = 12pt
#let size-label = 12pt
#let size-heading = 13pt
#let size-letter-header = 13pt

#let size-cover-form-title = 17pt
#let size-cover-organization = 13pt
#let size-cover-section = 11pt
#let size-cover-field-label = 12pt
#let size-radio = 10pt

#let weight-strong = "bold"
#let weight-regular = "regular"

// Spacing
#let space-xs = 0.35em
#let space-sm = 0.75em
#let space-md = 1em
#let space-lg = 1.5em
#let space-xl = 2em
#let space-stack-tight = 0.45em
#let space-stack-normal = 0.65em
#let space-stack-relaxed = 0.9em
#let radio-row-gap = 5em
#let gutter-field = 0.5em
#let gutter-radio = 1em
#let gutter-ref-box = 0.25em

// Layout
#let width-cover-form = 72%
#let width-cover-option-label = 2.6cm

// Reference digit boxes
#let count-ref-box = 4
#let width-ref-box = 1.1cm
#let height-ref-box = 0.75cm

// Body tables
#let height-supervisor-table-header = 1.05cm
#let height-supervisor-table-row = 1.2cm

// Page
#let paper = "a4"
#let margin-page = (x: 1.4cm, y: 1.4cm)
#let margin-cover = (x: 2cm, y: 2.2cm)

// Assets (see lib/assets.typ for paths)
#let logo-height-cover = 4.8cm

// Page chrome (running header/footer)
#let size-page-header = 13pt
#let size-page-number = 11pt
#let size-footnote = 10pt
#let stroke-page-rule = 0.5pt
#let space-header-rule = 0.35em
#let space-footer-rule = 0.25em
#let space-footer-notes = 0.35em
#let space-footnote-gap = 0.35em
#let header-ascent-page = 1.15cm
#let footer-descent-page = 1.1cm
