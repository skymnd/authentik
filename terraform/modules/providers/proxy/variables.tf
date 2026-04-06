variable "proxy_providers" {
  description = "Map of proxy providers to manage"
  type = map(object({
    name                  = string
    access_token_validity = optional(string)
    external_host         = string
    internal_host         = optional(string, "")
    mode                  = optional(string, "forward_single")
  }))
  default = {}
}

variable "authentication_flow_uuid" {
  description = "UUID of the authentication flow"
  type        = string
}

variable "authorization_flow_uuid" {
  description = "UUID of the authorization flow"
  type        = string
}

variable "invalidation_flow_uuid" {
  description = "UUID of the invalidation flow"
  type        = string
}
