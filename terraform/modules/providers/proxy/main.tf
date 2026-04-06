resource "authentik_provider_proxy" "proxy" {
  for_each = var.proxy_providers

  name                  = each.value.name
  authorization_flow    = var.authorization_flow_uuid
  invalidation_flow     = var.invalidation_flow_uuid
  authentication_flow   = var.authentication_flow_uuid
  access_token_validity = each.value.access_token_validity
  external_host         = each.value.external_host
  internal_host         = each.value.internal_host
  mode                  = each.value.mode
}
