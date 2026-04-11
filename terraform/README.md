# Authentik Terraform Configuration

This directory contains Terraform configuration for managing
authentik resources as code. It uses the
[goauthentik/authentik](https://registry.terraform.io/providers/goauthentik/authentik/latest)
Terraform provider to declaratively manage users, groups,
applications, and authentication flows.

## What it manages

- **Users** - admin users, regular users, and service accounts
- **Groups** - with automatic membership based on user config
- **Authentication flows** - authentication, authorization, and
  invalidation flows
- **OAuth2/OIDC applications** - via the `modules/applications/oauth2`
  module
- **Proxy applications** - via the `modules/applications/proxy` module,
  with an embedded outpost for forward auth
- **Per-application access control** - users and admins are bound to
  applications through group assignments

## Prerequisites

- Terraform >= 1.5.0
- A running authentik instance with an API token
- An S3 backend for remote state (configured via `backend.conf`)

## Getting started

1. Copy the example tfvars file and fill in your values:

   ```sh
   cp terraform.tfvars.example terraform.tfvars
   ```


2. Initialise Terraform with the backend config:

   ```sh
   terraform init -backend-config=backend.conf
   ```

3. Review and apply:

   ```sh
   terraform plan
   terraform apply
   ```

## File structure

| File                      | Purpose                                         |
| ------------------------- | ----------------------------------------------- |
| `main.tf`                 | Provider config, users, groups, and app modules  |
| `flows.tf`                | Authentication, authorization, and invalidation flows |
| `variables.tf`            | Input variable definitions                       |
| `locals.tf`              | Computed group and application memberships        |
| `versions.tf`            | Terraform and provider version constraints        |
| `backend.conf`           | S3 backend configuration                          |
| `terraform.tfvars.example`| Example variable values                          |
| `modules/applications/`  | Reusable modules for OAuth2 and proxy providers   |

## Sensitive values

The `authentik_url`, `authentik_token`, and email variables are
marked as sensitive. Keep your `terraform.tfvars` out of version
control (it should be in `.gitignore`) and use the
`terraform.tfvars.example` file as a reference.
