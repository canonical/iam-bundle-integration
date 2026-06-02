# Multitenancy Example

This Terraform plan deploys the Identity Platform with **multitenancy enabled**
across two Juju models (`core` and `iam`).

Multitenancy is implemented through three additional charms that work alongside
the standard IAM stack:

| Charm | Role |
|---|---|
| [tenant-service](https://charmhub.io/tenant-service) | Manages tenant lifecycle and issues per-tenant tokens via Hydra |
| [hook-service](https://charmhub.io/hook-service) | Runs webhook callbacks on Hydra token events |
| [kratos](https://charmhub.io/kratos) | Extended with registration and login webhook endpoints |

## Prerequisites

- `microk8s` (v1.25.0+) with DNS, storage, and registry add-ons enabled
- `juju` (3.1.0+) bootstrapped against MicroK8s
- `terraform` (v1.5.0+)

## Deploy

```shell
cd examples/multitenancy
terraform init
terraform apply -var-file=multitenancy.tfvars
```

The plan creates two Juju models:

- **`core`** — shared infrastructure: self-signed-certificates, Traefik, PostgreSQL, OpenFGA
- **`iam`** — identity services: Hydra, Kratos, Login UI, Tenant Service, Hook Service

Cross-model offers are created automatically so the `iam` model can consume
the database, CA certificate, OpenFGA, and ingress route from `core`.

## Configuration

Edit `multitenancy.tfvars` to adjust channels, revisions, or charm config.
To enable an external IdP (e.g. Google), add:

```hcl
enable_kratos_external_idp_integrator = true

kratos_external_idp_integrator = {
  config = {
    client_id     = "<client-id>"
    client_secret = "<client-secret>"
    provider      = "google"
    provider_id   = "google"
  }
}
```

## Tear down

```shell
juju destroy-model iam  --force --no-wait --destroy-storage
juju destroy-model core --force --no-wait --destroy-storage
terraform state list | xargs -L1 terraform state rm
```
