// Bilingual footnotes: Persian (RTL) and English (LTR).
#import "../../design/tokens.typ": font-english

#let en-footnote-body(content) = content

#let fa-footnote-body(content) = content

#let ltr-word(word) = text(font: font-english, dir: ltr)[#word]

#let fa-after(prefix, note) = [#prefix#footnote(fa-footnote-body(note))]

#let en-after(prefix, gloss) = [#prefix#footnote(en-footnote-body(gloss))]

#let render-segments(segments) = {
  for seg in segments {
    let t = seg.at("text", default: "")
    let en = seg.at("en", default: none)
    let fa = seg.at("fa", default: none)
    let inline-ltr = seg.at("ltr", default: false)
    if en != none {
      en-after(t, en)
    } else if fa != none {
      fa-after(t, fa)
    } else if inline-ltr {
      ltr-word(t)
    } else {
      t
    }
  }
}

// Scope for English-only blocks (bibliography, etc.).
#let ltr-block(body) = {
  set text(dir: ltr, lang: "en", font: font-english)
  set align(left)
  set par(justify: false)
  body
}
