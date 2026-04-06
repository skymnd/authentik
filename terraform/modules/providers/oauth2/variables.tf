variable "oauth2_providers" {
  description = "Map of OAuth2/OIDC providers to manage"
  type = map(object({
    name                    = string
    client_id               = string
    client_type             = optional(string, "confidential")
    access_token_validity   = optional(string, "minutes=5")
    refresh_token_threshold = optional(string, "hours=1")
    allowed_redirect_uris = optional(list(object({
      url           = string
      matching_mode = optional(string, "strict")
    })), [])
    signing_key       = optional(string)
    property_mappings = optional(list(string), [])
    sub_mode          = optional(string, "hashed_user_id")
    logout_method     = optional(string, "backchannel")
    logout_uri        = optional(string)
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
