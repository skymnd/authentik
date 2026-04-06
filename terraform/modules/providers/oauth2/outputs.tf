output "provider_ids" {
  description = "Map of OAuth2 provider key to provider ID"
  value       = { for k, p in authentik_provider_oauth2.oauth2 : k => p.id }
}
