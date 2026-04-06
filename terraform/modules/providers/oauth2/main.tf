resource "authentik_provider_oauth2" "oauth2" {
  for_each = var.oauth2_providers

  name                    = each.value.name
  authorization_flow      = var.authorization_flow_uuid
  invalidation_flow       = var.invalidation_flow_uuid
  authentication_flow     = var.authentication_flow_uuid
  client_id               = each.value.client_id
  client_type             = each.value.client_type
  access_token_validity   = each.value.access_token_validity
  refresh_token_threshold = each.value.refresh_token_threshold
  signing_key             = each.value.signing_key
  property_mappings       = each.value.property_mappings
  allowed_redirect_uris   = each.value.allowed_redirect_uris
  sub_mode                = each.value.sub_mode
  logout_method           = each.value.logout_method
  logout_uri              = each.value.logout_uri
}
