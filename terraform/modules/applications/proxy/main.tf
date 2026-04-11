resource "authentik_provider_proxy" "proxy" {
  name                  = var.name
  authorization_flow    = var.authorization_flow_uuid
  invalidation_flow     = var.invalidation_flow_uuid
  authentication_flow   = var.authentication_flow_uuid
  access_token_validity = var.access_token_validity
  external_host         = var.external_host
  internal_host         = var.internal_host
  mode                  = var.mode
}

resource "authentik_application" "app" {
  name               = var.application_name
  slug               = var.application_slug
  meta_launch_url    = var.meta_launch_url
  meta_description   = var.meta_description
  meta_publisher     = var.meta_publisher
  meta_icon          = var.meta_icon
  protocol_provider  = authentik_provider_proxy.proxy.id
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

resource "authentik_policy_binding" "app_users" {
  target = authentik_application.app.uuid
  group  = authentik_group.app_users.id
  order  = 0
}

resource "authentik_policy_binding" "app_admins" {
  target = authentik_application.app.uuid
  group  = authentik_group.app_admins.id
  order  = 1
}
