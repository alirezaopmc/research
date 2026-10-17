// Bilingual footnotes: Persian (RTL) and English (LTR).
#import "../../design/tokens.typ": font-english
#import "../../design/typography.typ": text-base-body

#let en-footnote-body(content) = {
  set text(font: font-english, dir: ltr, lang: "en")
  content
}

#let fa-footnote-body(content) = {
  set text(dir: rtl, lang: "fa")
  content
}

#let fa-after(prefix, note) = [#prefix#footnote(fa-footnote-body(note))]

#let en-after(prefix, gloss) = [#prefix#footnote(en-footnote-body(gloss))]

// English gloss followed by a Persian note in one footnote.
#let en-fa-after(prefix, gloss, note) = [
  #prefix#footnote[
    #en-footnote-body(gloss)
    #linebreak()
    #fa-footnote-body(note)
  ]
]

#let en-only-footnote(gloss) = footnote(en-footnote-body(gloss))

#let render-segments(segments) = {
  for seg in segments {
    let t = seg.at("text", default: "")
    let en = seg.at("en", default: none)
    let fa = seg.at("fa", default: none)
    let english-word = seg.at("ltr", default: false)
    if en != none and fa != none {
      en-fa-after(t, en, fa)
    } else if en != none {
      en-after(t, en)
    } else if fa != none {
      fa-after(t, fa)
    } else if english-word {
      en-only-footnote(t)
    } else {
      t
    }
  }
}

// Plain string or {segments: ...} rendered with footnotes, at body size.
#let rich-text(content) = {
  if type(content) == dictionary and content.at("segments", default: none) != none {
    text-base-body(render-segments(content.segments))
  } else {
    text-base-body(content)
  }
}

// Scope for English-only blocks (bibliography, etc.).
#let ltr-block(body) = {
  set text(dir: ltr, lang: "en", font: font-english)
  set align(left)
  set par(justify: false)
  body
}
