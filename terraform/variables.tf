variable "authentik_url" {
  description = "The URL of the authentik instance"
  type        = string
  sensitive   = true
}

variable "authentik_token" {
  description = "API token for authentik"
  type        = string
  sensitive   = true
}

variable "admins" {
  description = "Map of admin users (non-sensitive fields: username, name, groups)"
  type = map(object({
    username     = string
    name         = string
    groups       = optional(list(string), [])
    admin_groups = optional(list(string), [])
  }))
  default = {}
}

variable "admin_emails" {
  description = "Map of admin user emails, keyed to match admins"
  type        = map(string)
  default     = {}
  sensitive   = true
}

variable "users" {
  description = "Map of users (non-sensitive fields: username, name, groups)"
  type = map(object({
    username     = string
    name         = string
    groups       = optional(list(string), [])
    admin_groups = optional(list(string), [])
  }))
  default = {}
}

variable "user_emails" {
  description = "Map of user emails, keyed to match users"
  type        = map(string)
  default     = {}
  sensitive   = true
}

variable "service_accounts" {
  description = "Map of service accounts to create"
  type = map(object({
    username     = string
    name         = string
    groups       = optional(list(string), [])
    admin_groups = optional(list(string), [])
    attributes   = optional(string, "{}")
  }))
  default = {}
}

variable "groups" {
  description = "Map of groups to manage"
  type = map(object({
    is_superuser = optional(bool, false)
  }))
  default = {}
}

variable "oauth2_providers" {
  description = "Map of OAuth2/OIDC providers"
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
    sub_mode           = optional(string, "hashed_user_id")
    logout_method      = optional(string, "backchannel")
    logout_uri         = optional(string)
    application_name   = string
    application_slug   = string
    meta_launch_url    = string
    meta_description   = string
    meta_publisher     = string
    meta_icon          = optional(string, "")
    open_in_new_tab    = optional(bool, false)
    policy_engine_mode = optional(string, "any")
    application_group  = optional(string, "")
  }))
  default = {}
}

variable "proxy_providers" {
  description = "Map of proxy providers"
  type = map(object({
    name                  = string
    access_token_validity = optional(string)
    external_host         = string
    internal_host         = optional(string, "")
    mode                  = optional(string, "forward_single")
    application_name      = string
    application_slug      = string
    meta_launch_url       = string
    meta_description      = string
    meta_publisher        = string
    meta_icon             = optional(string, "")
    open_in_new_tab       = optional(bool, false)
    policy_engine_mode    = optional(string, "any")
    application_group     = optional(string, "")
  }))
  default = {}
}

variable "roles" {
  description = "Map of roles"
  type = map(object({
    name = string
  }))
  default = {}
}
