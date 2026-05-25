// Cover presentation logic: derive UI state from locale meta.

#let cover-selection(meta) = (
  masters-selected: meta.degree == "masters",
  phd-selected: meta.degree == "phd",
  day-selected: meta.study-mode == "day",
  evening-selected: meta.study-mode == "evening",
)
