terraform {
  required_version = ">= 1.5.0"

  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "~> 2025.2"
    }
  }

  backend "s3" {
    key     = "authentik/terraform.tfstate"
    profile = "terraform-state"
  }
}
