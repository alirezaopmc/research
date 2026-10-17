// Figure for section 4-2 (methodology): steering as an intervention on intermediate features.
// Drawn with absolute coordinates. Reading order is right to left, so inputs sit on the right.
#import "../../../design/colors.typ": color-ut-blue
#import "../../../design/typography.typ": text-base-body, text-base-label
#import "../../shared/figure.typ": (
  body-figure, diagram-band-top, diagram-stroke, diagram-stroke-emphasis,
)

#let panel-width = 16cm
#let panel-height = 6.4cm
#let node-radius = 0.22cm
#let tag-height = 0.8cm
#let link-stroke = 0.4pt + color-ut-blue
#let cross-stroke = 1.2pt + color-ut-blue

// Column x-positions and row y-positions (centres) inside a panel.
#let col-output = 2.2cm
#let col-hidden-2 = 6.2cm
#let col-hidden-1 = 9.2cm
#let col-input = 12.6cm
#let row-header = 0.4cm
#let row-input = (2.4cm, 3.4cm, 4.4cm)
#let row-hidden-1 = (2.4cm, 3.4cm, 4.4cm, 5.4cm)
#let row-hidden-2 = (2.9cm, 3.9cm, 4.9cm)

// Straight line between two centre points.
#let segment(a, b, stroke) = {
  let x0 = calc.min(a.at(0), b.at(0))
  let y0 = calc.min(a.at(1), b.at(1))
  place(top + left, dx: x0, dy: y0, line(
    start: (a.at(0) - x0, a.at(1) - y0),
    end: (b.at(0) - x0, b.at(1) - y0),
    stroke: stroke,
  ))
}

#let node(p, emphasis: false) = place(
  top + left,
  dx: p.at(0) - node-radius,
  dy: p.at(1) - node-radius,
  circle(
    radius: node-radius,
    fill: white,
    stroke: if emphasis { diagram-stroke-emphasis } else { diagram-stroke },
  ),
)

#let tag(p, width, body, emphasis: false) = place(
  top + left,
  dx: p.at(0) - width / 2,
  dy: p.at(1) - tag-height / 2,
  box(
    width: width,
    height: tag-height,
    inset: 4pt,
    fill: white,
    stroke: if emphasis { diagram-stroke-emphasis } else { diagram-stroke },
  )[#align(center + horizon)[#body]],
)

#let plain-label(p, width, body) = place(
  top + left,
  dx: p.at(0) - width / 2,
  dy: p.at(1) - tag-height / 2,
  box(width: width, height: tag-height)[#align(center + horizon)[#body]],
)

// Two crossed strokes over a node mark a suppressed feature.
#let cross(p) = {
  let d = node-radius * 0.7
  segment((p.at(0) - d, p.at(1) - d), (p.at(0) + d, p.at(1) + d), cross-stroke)
  segment((p.at(0) - d, p.at(1) + d), (p.at(0) + d, p.at(1) - d), cross-stroke)
}

#let steering-network(content, steered: false) = {
  let inputs = row-input.map(y => (col-input, y))
  let hidden-1 = row-hidden-1.map(y => (col-hidden-1, y))
  let hidden-2 = row-hidden-2.map(y => (col-hidden-2, y))
  let output-main = (col-output, row-hidden-2.at(1))
  let output-alt = (col-output, row-hidden-1.at(3))
  let injection = (12.9cm, 6.0cm)
  let injected-node = hidden-1.at(2)

  box(width: panel-width, height: panel-height)[
    // Links first, so nodes and tags cover their ends.
    #for a in inputs { for b in hidden-1 { segment(a, b, link-stroke) } }
    #for a in hidden-1 { for b in hidden-2 { segment(a, b, link-stroke) } }
    #for a in hidden-2 { segment(a, output-main, link-stroke) }
    #if steered {
      for a in hidden-2 { segment(a, output-alt, link-stroke) }
      segment(injection, injected-node, diagram-stroke-emphasis)
    }

    // Column headers (top panel only).
    #if not steered {
      plain-label((col-input, row-header), 3.6cm, text-base-label(content.header-input))
      plain-label(((col-hidden-1 + col-hidden-2) / 2, row-header), 4.6cm, text-base-label(content.header-hidden))
      plain-label((col-output, row-header), 3.0cm, text-base-label(content.header-output))
    }

    // Inputs.
    #for (p, label) in inputs.zip(content.input-labels) {
      tag(p, 2.6cm, text-base-body(label))
    }

    // Intermediate features: capital and Texas are the features of interest.
    #for (i, p) in hidden-1.enumerate() {
      node(p, emphasis: i == 0 or i == 3 or (steered and i == 2))
    }
    #for p in hidden-2 { node(p) }

    // Feature names.
    #plain-label((col-hidden-1 - 1.6cm, row-hidden-1.at(0)), 2.6cm, text-base-body(content.capital-feature))
    #plain-label((col-hidden-1 - 1.6cm, row-hidden-1.at(3)), 2.6cm, text-base-body(content.texas-feature))

    // Outputs.
    #if steered {
      tag(output-main, 3.0cm, text-base-body(content.output-steered), emphasis: true)
      tag(output-alt, 3.0cm, text-base-body(content.output-original))
    } else {
      tag(output-main, 3.0cm, text-base-body(content.output-original), emphasis: true)
    }

    // Intervention: suppress the Texas feature and inject the steering vector.
    #if steered {
      cross(hidden-1.at(3))
      plain-label((col-hidden-1, row-hidden-1.at(3) + 0.6cm), 2.0cm, text-base-body(content.inhibited))
      tag(injection, 4.2cm, text-base-body(content.injected))
    }
  ]
}

#let steering-figure(content) = body-figure(
  stack(
    spacing: 0.6em,
    diagram-band-top(content.row-normal),
    steering-network(content),
    diagram-band-top(content.row-steered),
    steering-network(content, steered: true),
  ),
  content.caption,
)
