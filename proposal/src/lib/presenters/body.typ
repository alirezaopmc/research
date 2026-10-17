// Body presentation logic: derive UI state from locale meta.

#let body-selection(meta) = (
  fundamental-selected: meta.summary.thesis-type == "fundamental",
  applied-selected: meta.summary.thesis-type == "applied",
  developmental-selected: meta.summary.thesis-type == "developmental",
)

// Optional supervisor rows (حسب نیاز) appear only once a name is entered.
#let supervisor-visible-rows(rows) = rows.filter(row => {
  str(row.at("name", default: "")).trim().len() > 0
})

#let supervisor-role-label(labels, role) = {
  if role == "primary" {
    labels.supervisor-role-primary
  } else if role == "secondary" {
    labels.supervisor-role-secondary
  } else if role == "advisor-primary" {
    labels.supervisor-role-advisor-primary
  } else {
    labels.supervisor-role-advisor-secondary
  }
}
