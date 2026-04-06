resource "authentik_flow" "authentication" {
  name               = "Welcome to authentik!"
  slug               = "default-authentication-flow"
  title              = "Welcome to authentik!"
  designation        = "authentication"
  background         = "/static/dist/assets/images/flow_background.jpg"
  compatibility_mode = false
}

resource "authentik_flow" "authorization" {
  name               = "Authorize Application"
  slug               = "default-provider-authorization-explicit-consent"
  title              = "Redirecting to %(app)s"
  designation        = "authorization"
  authentication     = "require_authenticated"
  background         = "/static/dist/assets/images/flow_background.jpg"
  compatibility_mode = false
}

resource "authentik_flow" "invalidation" {
  name               = "Logged out of application"
  slug               = "default-provider-invalidation-flow"
  title              = "You've logged out of %(app)s."
  designation        = "invalidation"
  background         = "/static/dist/assets/images/flow_background.jpg"
  compatibility_mode = false
}