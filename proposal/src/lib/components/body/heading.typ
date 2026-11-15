// Shared body heading: number printed beside a heading element that holds only the title.
// PDF bookmarks and the table of contents read the heading element, so they show titles without numbers.
#import "../../design/typography.typ": text-base-heading

#let body-heading(level, number, title) = [
  // Numbers read left to right inside the right-to-left line. No bidi isolate marks here: they reverse the digits.
  #text(dir: ltr)[#text-base-heading[#(number + ".")]]
  #h(0.35em)
  #box(heading(level: level)[#text-base-heading[#title]])
]
