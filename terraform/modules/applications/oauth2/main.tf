resource "authentik_provider_oauth2" "oauth2" {
  name                    = var.name
  authorization_flow      = var.authorization_flow_uuid
  invalidation_flow       = var.invalidation_flow_uuid
  authentication_flow     = var.authentication_flow_uuid
  client_id               = var.client_id
  client_type             = var.client_type
  access_token_validity   = var.access_token_validity
  refresh_token_threshold = var.refresh_token_threshold
  signing_key             = var.signing_key
  property_mappings       = var.property_mappings
  allowed_redirect_uris   = var.allowed_redirect_uris
  sub_mode                = var.sub_mode
  logout_method           = var.logout_method
  logout_uri              = var.logout_uri
}

resource "authentik_application" "app" {
  name               = var.application_name
  slug               = var.application_slug
  meta_launch_url    = var.meta_launch_url
  meta_description   = var.meta_description
  meta_publisher     = var.meta_publisher
  meta_icon          = var.meta_icon
  protocol_provider  = authentik_provider_oauth2.oauth2.id
  open_in_new_tab    = var.open_in_new_tab
  policy_engine_mode = var.policy_engine_mode
  group              = var.application_group
}

resource "authentik_group" "app_users" {
  name  = "${var.application_name} Users"
  users = var.user_members
}

resource "authentik_group" "app_admins" {
  name  = "${var.application_name} Admins"
  users = var.admin_members
}
