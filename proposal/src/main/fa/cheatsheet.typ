// Two-page skim sheet: summary of the proposal for quick review.
#import "../../lib/design/tokens.typ": font-stack
#import "../../lib/design/colors.typ": color-ut-blue, color-ink
#import "../../lib/components/shared.typ": to-persian-digits

#let data = yaml("../../content/fa/cheatsheet/meta/cheatsheet.yaml")

#set document(title: data.title, author: "علیرضا جعفرتاش")
#set page(
  paper: "a4",
  margin: (x: 1.3cm, top: 1.1cm, bottom: 1.3cm),
  fill: white,
  footer: context align(center, text(size: 8pt)[#to-persian-digits(counter(page).display())]),
)
#set text(lang: "fa", dir: rtl, font: font-stack, size: 10.6pt, fill: color-ink)
#set par(leading: 0.42em, spacing: 0.42em, justify: false)
#set list(indent: 0pt, body-indent: 0.4em, spacing: 0.25em)

#let section(title, body) = {
  v(0.35em)
  block(width: 100%, sticky: true)[
    #text(weight: "bold", size: 9.8pt, fill: color-ut-blue)[#title]
    #v(0.05em)
    #line(length: 100%, stroke: 0.4pt + color-ut-blue)
  ]
  v(0.15em)
  block(breakable: false, width: 100%, body)
}

#let cell-table(rows, widths) = table(
  columns: widths,
  stroke: 0.3pt + color-ut-blue,
  inset: (x: 4pt, y: 2.4pt),
  align: (right, right),
  ..rows.flatten(),
)

// Header
#align(center)[
  #text(weight: "bold", size: 14pt, fill: color-ut-blue)[#data.title]
  #v(0.1em)
  #text(weight: "bold", size: 10pt)[#data.subtitle]
  #v(0.2em)
  #for line in data.identity [
    #text(size: 8.2pt)[#line] \
  ]
]

#section("ایده در یک جمله")[
  #data.idea
]

#section("پرسش‌های پژوهش")[
  #for q in data.questions [
    - #q
  ]
]

#section("چرا مهم است")[
  #for w in data.why [
    - #w
  ]
]

#section("روش")[
  #table(
    columns: (2.6cm, 1fr),
    stroke: 0.3pt + color-ut-blue,
    inset: (x: 4pt, y: 2.4pt),
    align: (right + top, right + top),
    ..data.method.map(m => (text(weight: "bold")[#m.label], m.text)).flatten(),
  )
]

#section("مراحل و خروجی‌ها (۱۲ ماه)")[
  #table(
    columns: (1.6cm, 3.2cm, 1fr, 1fr),
    stroke: 0.3pt + color-ut-blue,
    inset: (x: 4pt, y: 2.4pt),
    align: (right + horizon, right + horizon, right + horizon, right + horizon),
    table.header(
      text(weight: "bold", fill: color-ut-blue)[ماه],
      text(weight: "bold", fill: color-ut-blue)[مرحله],
      text(weight: "bold", fill: color-ut-blue)[کار],
      text(weight: "bold", fill: color-ut-blue)[خروجی],
    ),
    ..data.phases.map(p => (p.months, p.label, p.work, p.output)).flatten(),
  )
]

#section("ریسک‌ها و نکات بازبینی")[
  #for r in data.risks [
    - #r
  ]
]

#section("واژگان کلیدی")[
  #table(
    columns: (3.4cm, 1fr),
    stroke: 0.3pt + color-ut-blue,
    inset: (x: 4pt, y: 2pt),
    align: (right + top, right + top),
    ..data.terms.map(t => (text(weight: "bold")[#t.term], t.def)).flatten(),
  )
]

#section("منابع کلیدی")[
  #for r in data.refs [
    - #r
  ]
]

#section("وضعیت و کارهای باقی‌مانده")[
  #for o in data.open [
    - #o
  ]
]
