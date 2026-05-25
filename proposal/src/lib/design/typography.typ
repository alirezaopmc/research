// Typography system: make-style factory, role namespaces, flat text-* exports.
#import "tokens.typ": *

#let make-style(
  size: size-body,
  weight: weight-regular,
  style: "normal",
) = body => text(size: size, weight: weight, style: style)[#body]

// Shared letter roles
#let base = (
  body: make-style(size: size-body),
  heading: make-style(size: size-heading, weight: weight-strong),
  label: make-style(size: size-label, weight: weight-strong),
  inline-label: make-style(weight: weight-strong),
)

// Cover page roles
#let cover = (
  form-title: make-style(size: size-cover-form-title, weight: weight-strong),
  organization: make-style(size: size-cover-organization, weight: weight-strong),
  section: make-style(size: size-cover-section, weight: weight-strong),
  field-label: make-style(size: size-cover-field-label, weight: weight-strong),
)

// Letter page roles
#let letter = (
  header: make-style(size: size-letter-header, weight: weight-strong),
)

// Flat bindings for components; text-* prefix avoids clashing with component names.
#let text-base-body = base.body
#let text-base-heading = base.heading
#let text-base-label = base.label
#let text-base-inline-label = base.inline-label

#let text-cover-form-title = cover.form-title
#let text-cover-organization = cover.organization
#let text-cover-section = cover.section
#let text-cover-field-label = cover.field-label

#let text-letter-header = letter.header

#let text-page-header(body) = text(size: size-page-header, weight: weight-strong)[#body]
#let text-page-number(body) = text(size: size-page-number)[#body]
#let text-footnote(body) = text(size: size-footnote)[#body]
