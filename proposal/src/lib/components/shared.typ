// Shared UI primitives used by cover and letter.
#import "../design/tokens.typ": gutter-field

#let to-persian-digits(content) = {
  if type(content) == int {
    to-persian-digits(str(content))
  } else if type(content) == str {
    let eastern = (
      "0": "۰", "1": "۱", "2": "۲", "3": "۳", "4": "۴",
      "5": "۵", "6": "۶", "7": "۷", "8": "۸", "9": "۹",
    )
    content.replace(regex("[0-9]"), match => eastern.at(match.text))
  } else {
    content
  }
}

// ASCII digits/dates → Persian; emails and Latin tokens stay LTR.
#let ltr-value(content) = {
  if type(content) == str and content.len() > 0 {
    let latin = regex("^[0-9/.\-+@a-zA-Z:_]+$")
    if content.match(latin) != none {
      let persian = to-persian-digits(content)
      if content.match(regex("[a-zA-Z@]")) != none {
        text(dir: ltr)[#persian]
      } else {
        persian
      }
    } else {
      content
    }
  } else {
    content
  }
}

#let labeled-field(label, value, label-style, row-gutter: 0em) = {
  grid(
    columns: (auto, 1fr),
    column-gutter: gutter-field,
    row-gutter: row-gutter,
    align: horizon,
    label-style(label + ":"),
    value,
  )
}
