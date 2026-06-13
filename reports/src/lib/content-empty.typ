// Detect absent or blank section bodies (empty content blocks, none, empty arrays).

#let content-empty(body) = {
  if body == none { return true }
  if body == [] { return true }
  if type(body) == array and body.len() == 0 { return true }
  false
}
