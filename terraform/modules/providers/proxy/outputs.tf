output "provider_ids" {
  description = "Map of proxy provider key to provider ID"
  value       = { for k, p in authentik_provider_proxy.proxy : k => p.id }
}
