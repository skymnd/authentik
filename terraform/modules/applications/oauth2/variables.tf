# --- OAuth2 Provider ---

variable "name" {
  description = "Name of the OAuth2 provider"
  type        = string
}

variable "client_id" {
  description = "OAuth2 client ID"
  type        = string
}

variable "client_type" {
  description = "OAuth2 client type"
  type        = string
  default     = "confidential"
}

variable "access_token_validity" {
  description = "Access token validity duration"
  type        = string
  default     = "minutes=5"
}

variable "refresh_token_threshold" {
  description = "Refresh token threshold duration"
  type        = string
  default     = "hours=1"
}

variable "allowed_redirect_uris" {
  description = "List of allowed redirect URIs"
  type = list(object({
    url           = string
    matching_mode = optional(string, "strict")
  }))
  default = []
}

variable "signing_key" {
  description = "Signing key ID"
  type        = string
  default     = null
}

variable "property_mappings" {
  description = "List of property mapping IDs"
  type        = list(string)
  default     = []
}

variable "sub_mode" {
  description = "Subject mode"
  type        = string
  default     = "hashed_user_id"
}

variable "logout_method" {
  description = "Logout method"
  type        = string
  default     = "backchannel"
}

variable "logout_uri" {
  description = "Logout URI"
  type        = string
  default     = null
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

# --- Application ---

variable "application_name" {
  description = "Name of the application"
  type        = string
}

variable "application_slug" {
  description = "Slug of the application"
  type        = string
}

variable "meta_launch_url" {
  description = "Launch URL for the application"
  type        = string
}

variable "meta_description" {
  description = "Description of the application"
  type        = string
}

variable "meta_publisher" {
  description = "Publisher of the application"
  type        = string
}

variable "meta_icon" {
  description = "Icon for the application"
  type        = string
  default     = ""
}

variable "open_in_new_tab" {
  description = "Whether to open the application in a new tab"
  type        = bool
  default     = false
}

variable "policy_engine_mode" {
  description = "Policy engine mode for the application"
  type        = string
  default     = "any"
}

variable "application_group" {
  description = "Application group"
  type        = string
  default     = ""
}

# --- Groups ---

variable "user_members" {
  description = "List of user IDs for the application user group"
  type        = list(number)
  default     = []
}

variable "admin_members" {
  description = "List of user IDs for the application admin group"
  type        = list(number)
  default     = []
}
