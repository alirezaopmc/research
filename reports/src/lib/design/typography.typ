// Typography system: make-style factory + flat text-* role exports.
#import "tokens.typ": *

#let make-style(
  size: size-body,
  weight: weight-regular,
  fill: black,
  style: "normal",
) = body => text(size: size, weight: weight, fill: fill, style: style)[#body]

#let text-title = make-style(size: size-title, weight: weight-strong, fill: color-accent)
#let text-university = make-style(size: size-researcher, weight: weight-strong)
#let text-affiliation = make-style(size: size-position, fill: color-muted)
#let text-researcher = make-style(size: size-researcher, weight: weight-strong)
#let text-position = make-style(size: size-position, fill: color-muted)
#let text-report-number = make-style(size: size-report-number, weight: weight-strong, fill: color-accent)
#let text-report-date = make-style(size: size-report-date, fill: color-muted)
#let text-meta-label = make-style(size: size-meta, weight: weight-strong)
#let text-meta-value = make-style(size: size-meta)
#let text-challenge-detail = make-style(size: size-body, fill: luma(15%))

#let text-section = make-style(size: size-section, weight: weight-strong, fill: color-accent)
#let text-subsection = make-style(size: size-subsection, weight: weight-strong)
#let text-panel-title = make-style(size: size-subsection, weight: weight-strong, fill: color-accent)
#let text-tldr-body = make-style(size: 11.5pt, fill: luma(15%))

#let text-page-header = make-style(size: size-page-header, fill: color-muted)
#let text-page-number = make-style(size: size-page-number, fill: color-muted)
