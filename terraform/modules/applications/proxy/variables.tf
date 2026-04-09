# --- Proxy Provider ---

variable "name" {
  description = "Name of the proxy provider"
  type        = string
}

variable "access_token_validity" {
  description = "Access token validity duration"
  type        = string
  default     = null
}

variable "external_host" {
  description = "External host URL"
  type        = string
}

variable "internal_host" {
  description = "Internal host URL"
  type        = string
  default     = ""
}

variable "mode" {
  description = "Proxy mode"
  type        = string
  default     = "forward_single"
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
  default     = true
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
