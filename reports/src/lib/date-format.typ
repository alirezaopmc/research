// Derive a compact date label from a full period string.

#let month-abbrevs = (
  ("January", "Jan"),
  ("February", "Feb"),
  ("March", "Mar"),
  ("April", "Apr"),
  ("May", "May"),
  ("June", "Jun"),
  ("July", "Jul"),
  ("August", "Aug"),
  ("September", "Sep"),
  ("October", "Oct"),
  ("November", "Nov"),
  ("December", "Dec"),
)

#let abbreviate-months(text) = {
  let out = text
  for (full, abbr) in month-abbrevs {
    out = out.replace(full, abbr)
  }
  out
}

#let short-year(text) = text.replace(regex("20(\\d{2})"), m => "'" + m.captures.at(0))

#let format-short-date(period) = {
  if period == "" { return none }
  let end = if period.contains(" - ") {
    period.split(" - ").last()
  } else {
    period
  }
  short-year(abbreviate-months(end.trim()))
}
