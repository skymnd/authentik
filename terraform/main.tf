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
  source = "./modules/providers/oauth2"

  oauth2_providers         = var.oauth2_providers
  authentication_flow_uuid = authentik_flow.authentication.uuid
  authorization_flow_uuid  = authentik_flow.authorization.uuid
  invalidation_flow_uuid   = authentik_flow.invalidation.uuid
}

module "proxy" {
  source = "./modules/providers/proxy"

  proxy_providers          = var.proxy_providers
  authentication_flow_uuid = authentik_flow.authentication.uuid
  authorization_flow_uuid  = authentik_flow.authorization.uuid
  invalidation_flow_uuid   = authentik_flow.invalidation.uuid
}

resource "authentik_application" "apps" {
  for_each = var.applications

  name               = each.value.name
  slug               = each.value.slug
  meta_launch_url    = each.value.meta_launch_url
  meta_description   = each.value.meta_description
  meta_publisher     = each.value.meta_publisher
  meta_icon          = each.value.meta_icon
  protocol_provider  = each.value.provider_id
  open_in_new_tab    = each.value.open_in_new_tab
  policy_engine_mode = each.value.policy_engine_mode
  group              = each.value.group
}
