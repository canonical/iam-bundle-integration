# IAM Bundle Terraform Module

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

## Contributing

Please refer to the [doc](./CONTRIBUTING.md) to learn how to make code changes.
