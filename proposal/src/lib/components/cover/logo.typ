// Cover branding: university logo.
#import "../../design/tokens.typ": logo-height-cover

#let logo-ut = "../../../../assets/logos/university-of-tehran.png"

#let cover-logo(
  path: logo-ut,
  height: logo-height-cover,
) = image(path, height: height)
