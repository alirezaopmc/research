// Section 2: accomplishments & progress (three labelled subsections).
#import "../content-empty.typ": content-empty
#import "../design/tokens.typ": space-md
#import "section.typ": section-heading, subsection-heading

#let accomplishment-subsection(label, body) = {
  if content-empty(body) { [] } else {
    [
      #subsection-heading(label)
      #body
    ]
  }
}

#let accomplishments-section(labels, research, implementation, writing, number: "1") = {
  let blocks = (
    accomplishment-subsection(labels.accomplishments-research, research),
    accomplishment-subsection(labels.accomplishments-implementation, implementation),
    accomplishment-subsection(labels.accomplishments-writing, writing),
  )
  let visible = blocks.filter(b => b != [])

  if visible.len() == 0 { [] } else {
    [
      #section-heading(number, labels.section-accomplishments)
      #for (i, block) in visible.enumerate() [
        #block
        #if i < visible.len() - 1 [#v(space-md, weak: true)]
      ]
    ]
  }
}
