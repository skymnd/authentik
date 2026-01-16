# Authentik in a homelab

This repo is my personal configuration for using authentik
on my homelab.
Authentik is an IdP and SSO platform, and the
[authentik docs](https://docs.goauthentik.io/) are 
pretty good and can explain a bit more about what that
means.
This authentik instance is currently not internet-facing
and is deployed using the service in the `docker-compose.yml`
file.

This is mostly set up using the default settings, but
port 9300 has been exposed for Prometheus metrics.