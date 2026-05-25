// Content layer: YAML loading and locale assembly.

#let merge-dicts(..dicts) = {
  let result = (:)
  for dict in dicts.pos() {
    for (key, value) in dict {
      result.insert(key, value)
    }
  }
  result
}

#let merge-dicts-strict(..dicts) = {
  let result = (:)
  for dict in dicts.pos() {
    for (key, value) in dict {
      assert(
        result.at(key, default: none) == none,
        message: "duplicate locale key: " + key,
      )
      result.insert(key, value)
    }
  }
  result
}

#let locale-base(locale) = "../content/" + locale

#let document-base(locale, document) = locale-base(locale) + "/" + document

#let join-path(base, ..parts) = {
  let path = base
  for part in parts.pos() {
    path += "/" + part
  }
  path + ".yaml"
}

#let load-yaml(base, ..parts) = yaml(join-path(base, ..parts))

#let load-cover-locale(locale: "fa", document: "cover") = {
  let base = locale-base(locale)
  let doc = document-base(locale, document)
  let labels = load-yaml(doc, "labels", "cover")
  let meta = merge-dicts-strict(
    load-yaml(base, "shared", "meta", "organization"),
    load-yaml(doc, "meta", "organization"),
    load-yaml(doc, "meta", "student"),
    load-yaml(doc, "meta", "form"),
  )
  (
    labels: labels,
    meta: meta,
  )
}

#let load-body-locale(locale: "fa", document: "body") = {
  let base = locale-base(locale)
  let doc = document-base(locale, document)
  let labels = merge-dicts(
    load-yaml(base, "shared", "labels", "common"),
    load-yaml(doc, "labels", "body"),
  )
  (
    labels: labels,
    meta: (
      summary: load-yaml(doc, "meta", "summary"),
      supervisors: load-yaml(doc, "meta", "supervisors"),
      student: load-yaml(doc, "meta", "student"),
      topic: load-yaml(doc, "meta", "topic"),
    ),
  )
}

