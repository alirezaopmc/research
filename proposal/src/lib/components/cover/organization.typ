// Cover affiliation block under the logo.
#import "../../design/tokens.typ": space-stack-relaxed
#import "../../design/typography.typ": text-cover-organization
#import "../../design/layout.typ": centered-stack

#let cover-organization(meta) = centered-stack(
  spacing: space-stack-relaxed,
  text-cover-organization(meta.faculty),
  text-cover-organization(meta.college),
  text-cover-organization(meta.university),
)
