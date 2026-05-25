// Wraps a cover block with configurable before/after spacing from tokens.
#import "../../design/cover-spacing.typ": cover-spacing

#let cover-section(name, body) = {
  let pad = cover-spacing.at(name)
  [
    #v(pad.before)
    #body
    #v(pad.after)
  ]
}
