// Content layer: load report labels.

#let load-labels(locale: "en") = yaml(
  "../content/" + locale + "/labels/report.yaml",
)
