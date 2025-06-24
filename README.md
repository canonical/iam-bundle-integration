# Identity Platform Juju Bundle Terraform Module

[![Latest Release](https://img.shields.io/github/release/canonical/iam-bundle-integration.svg?label=Release)](https://github.com/canonical/iam-bundle-integration/releases/latest)
[![Juju Provider](https://img.shields.io/badge/Juju%20Provider-0.11.0-%23E95420)](https://registry.terraform.io/providers/juju/juju/0.11.0)
[![Terraform](https://img.shields.io/badge/Terraform-v1.5.0+-%23713DAD?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![License](https://img.shields.io/github/license/canonical/iam-bundle-integration?label=License)](https://github.com/canonical/iam-bundle-integration/blob/main/LICENSE)

[![Build](https://img.shields.io/github/actions/workflow/status/canonical/iam-bundle-integration/pull_request.yaml?label=Build)](https://github.com/canonical/iam-bundle-integration/actions/workflows/pull_request.yaml)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196.svg)](https://conventionalcommits.org)

This Identity Platform Juju bundle Terraform module aims to deploy
the [Identity Platform Juju Bundle](https://github.com/canonical/iam-bundle) via
Terraform.

## Getting started

### Prerequisites

Make sure the following software and tools are installed and running
in the local environment.

- `microk8s (v1.25.0+)`
- `juju (3.1.0+)`
- `terraform (v1.5.0+)`

### Deploy locally with Terraform

First, create Juju models for the Identity Platform and its dependencies:

```shell
juju add-model identity-platform
juju add-model core
```

#### Dependencies

Deploy the dependencies: [traefik](https://charmhub.io/traefik-k8s), [postgresql](https://charmhub.io/postgresql-k8s), [openfga](https://charmhub.io/openfga-k8s),
and a certificates charm (e.g. [lego](https://charmhub.io/lego) or [self-signed-certificates](https://charmhub.io/self-signed-certificates)).
And make sure they provide Juju offers:

```shell
# Deploy dependencies
juju deploy traefik-k8s traefik-public --trust --channel latest/stable
juju deploy postgresql-k8s --trust --channel 14/stable
juju deploy openfga-k8s --trust --channel latest/stable
juju deploy self-signed-certificates --trust --channel latest/stable

# Add integrations
juju integrate openfga-k8s postgresql-k8s
juju integrate traefik-public self-signed-certificates:send-ca-cert

# Create the juju offers
juju offer traefik-public:ingress ingress
juju offer traefik-public:traefik-route traefik-route
juju offer postgresql-k8s:database pg-database
juju offer openfga-k8s:openfga openfga
juju offer self-signed-certificates:send-ca-cert send-ca-cert
```

Alternatively, you can deploy the core dependencies with:

```shell
terraform -chdir=modules/core init
terraform -chdir=modules/core apply
```

Because the bundle uses an external identity provider (e.g. Google or Microsoft Entra ID),
it needs to provide additional variables for the module to run. More
information about the IdP configuration can be
found [here](https://charmhub.io/kratos-external-idp-integrator/configurations).
Refer to [this](https://support.google.com/cloud/answer/15549257) article to find out how to create a private client in Google.

Please create a Terraform variable definition (`.tfvars`) file in the root
directory as follows:

```shell
# vars.tfvars
idp_provider_config = {
  client_id           = <client id>
  provider            = <provider name>  # e.g. "google"
  provider_id         = <provider id>
}

idp_provider_credentials = {
  client_secret = <client secret>
}

postgresql_offer_url = "admin/core.postgresql"
ingress_offer_url = "admin/core.ingress"
openfga_offer_url = "admin/core.openfga"
send_ca_certificate_offer_url = "admin/core.send-ca-cert"
```

Run `juju find-offers` to fetch the offer URLs.

#### Identity Platform

Run the following commands to deploy the bundle:

```shell
terraform init
terraform apply -var-file="./vars.tfvars"
```

Run `juju switch <juju model>` to switch to the target Juju model.

```shell
# Observe the status of the applications and integrations
juju status --relations
```

### Deploy to the ProdStack 6 Cloud

Please refer to the [deployment documentation](docs/DEPLOYMENT.md) to learn
how to deploy the module to the ProdStack Cloud.

## Terraform Module Specifications

Please refer to the [module specifications](./MODULE_SPECS.md) to learn the
module specifications.

## Security

Please see [SECURITY.md](https://github.com/canonical/iam-bundle-integration/blob/main/SECURITY.md)
for guidelines on reporting security issues.

## Contributing

Please refer to the [contribution documentation](./CONTRIBUTING.md) to learn how
to contribute to the project.
