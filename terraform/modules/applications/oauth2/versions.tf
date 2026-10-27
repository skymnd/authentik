terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "~> 2026.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}
