provider "authentik" {
  url   = var.authentik_url
  token = var.authentik_token
}

resource "authentik_user" "admins" {
  for_each = var.admins

  username = each.value.username
  email    = var.admin_emails[each.key]
  name     = each.value.name
}

resource "authentik_user" "users" {
  for_each = var.users

  username = each.value.username
  email    = var.user_emails[each.key]
  name     = each.value.name
}

resource "authentik_user" "service_accounts" {
  for_each = var.service_accounts

  username   = each.value.username
  name       = each.value.name
  type       = "service_account"
  path       = "goauthentik.io/service-accounts"
  attributes = each.value.attributes
}

resource "authentik_group" "groups" {
  for_each = var.groups

  name         = each.key
  is_superuser = each.value.is_superuser
  users        = local.group_memberships[each.key]
}

module "oauth2" {
  source   = "./modules/applications/oauth2"
  for_each = var.oauth2_providers

  name                     = each.value.name
  client_id                = each.value.client_id
  client_type              = each.value.client_type
  access_token_validity    = each.value.access_token_validity
  refresh_token_threshold  = each.value.refresh_token_threshold
  signing_key              = each.value.signing_key
  property_mappings        = each.value.property_mappings
  allowed_redirect_uris    = each.value.allowed_redirect_uris
  sub_mode                 = each.value.sub_mode
  logout_method            = each.value.logout_method
  logout_uri               = each.value.logout_uri
  application_name         = each.value.application_name
  application_slug         = each.value.application_slug
  meta_launch_url          = each.value.meta_launch_url
  meta_description         = each.value.meta_description
  meta_publisher           = each.value.meta_publisher
  meta_icon                = each.value.meta_icon
  open_in_new_tab          = each.value.open_in_new_tab
  policy_engine_mode       = each.value.policy_engine_mode
  application_group        = each.value.application_group
  authentication_flow_uuid = authentik_flow.authentication.uuid
  authorization_flow_uuid  = authentik_flow.authorization.uuid
  invalidation_flow_uuid   = authentik_flow.invalidation.uuid
  user_members             = local.application_users[each.key]
  admin_members            = local.application_admins[each.key]
}

module "proxy" {
  source   = "./modules/applications/proxy"
  for_each = var.proxy_providers

  name                     = each.value.name
  access_token_validity    = each.value.access_token_validity
  external_host            = each.value.external_host
  internal_host            = each.value.internal_host
  mode                     = each.value.mode
  application_name         = each.value.application_name
  application_slug         = each.value.application_slug
  meta_launch_url          = each.value.meta_launch_url
  meta_description         = each.value.meta_description
  meta_publisher           = each.value.meta_publisher
  meta_icon                = each.value.meta_icon
  open_in_new_tab          = each.value.open_in_new_tab
  policy_engine_mode       = each.value.policy_engine_mode
  application_group        = each.value.application_group
  authentication_flow_uuid = authentik_flow.authentication.uuid
  authorization_flow_uuid  = authentik_flow.authorization.uuid
  invalidation_flow_uuid   = authentik_flow.invalidation.uuid
  user_members             = local.application_users[each.key]
  admin_members            = local.application_admins[each.key]
}

resource "authentik_outpost" "embedded" {
  name               = "authentik Embedded Outpost"
  type               = "proxy"
  protocol_providers = [for k, v in module.proxy : v.provider_id]
}

# Standalone Jellyfin application (provider managed outside terraform)
resource "authentik_application" "jellyfin" {
  name               = "Jellyfin"
  slug               = "jellyfin"
  protocol_provider  = 28
  policy_engine_mode = "any"
  group              = "Media"
}

