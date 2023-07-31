# IAM Bundle Terraform Module

[![Build](https://img.shields.io/github/actions/workflow/status/wood-push-melon/iam-bundle-test/pull_request.yaml?label=Build)](https://github.com/canonical/iam-bundle-integration/actions/workflows/pull_request.yaml)
[![Latest Release](https://img.shields.io/github/release/canonical/iam-bundle-integration.svg?label=Release)](https://github.com/canonical/iam-bundle-integration/releases/latest)
[![Juju Provider](https://img.shields.io/badge/Juju%20Provider-0.8.0-%23E95420)](https://registry.terraform.io/providers/juju/juju/0.8.0)
[![Terraform](https://img.shields.io/badge/Terraform-v1.5.0+-%23713DAD?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196.svg)](https://conventionalcommits.org)
[![License](https://img.shields.io/github/license/canonical/iam-bundle-integration?label=License)](https://github.com/canonical/iam-bundle-integration/blob/main/LICENSE)

This IAM bundle Terraform module aims to deploy
the [IAM Bundle](https://github.com/canonical/iam-bundle) via Terraform.

## Getting started

### Prerequisites

Make sure the following software and tools are installed and running
in the local environment.

- `microk8s (v1.25.0+)`
- `juju (3.1.0+)`
- `terraform (v1.5.0+)`

### Deploy locally with Terraform

Because the IAM bundle uses an external Idp provider (e.g. Microsoft Azure),
it needs to provide additional variables for the module to run. More
information about the Idp provider configuration can be
found [here](https://github.com/canonical/kratos-external-idp-integrator/blob/main/config.yaml).
Please create a Terraform variable definition (`.tfvars`) file in the root
directory as follows.

```shell
# idp_provider.tfvars
idp_provider_config = {
  client_id           = <client id>
  provider            = <provider name>
  provider_id         = <provider id>
  microsoft_tenant_id = <tenant id> # if using Microsoft Azure
}

idp_provider_credentials = {
  client_secret = <client secret>
}
```

Run the following commands to deploy the IAM bundle.

```shell
$ terraform init
$ terraform apply -var-files="./idp_provider.tfvars"
```

Run `juju switch iam-bundle` to use the created Juju model.

```shell
# Observe the status of the applications and integrations
$ juju status --relations
```

### Deploy to the Canonical Cloud

TBD.

## Terraform Module Specifications

Please refer to the [module specifications](./MODULE_SPECS.md) to learn the
module specifications.

## Contributing

Please refer to the [contribution documentation](./CONTRIBUTING.md) to learn how
to contribute to the project.
