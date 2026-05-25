// Right-aligned form panel inside a centered width constraint.
#import "../../design/tokens.typ": width-cover-form
#import "../../design/layout.typ": centered-block

#let cover-form-panel(body) = centered-block[
  #box(width: width-cover-form)[
    #set align(right)
    #body
  ]
]
