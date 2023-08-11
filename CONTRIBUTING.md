# Contributing to Identity Platform Juju bundle Terraform module

## Development environment

### Prerequisites

Make sure the following software and tools are installed in the development
environment.

- `microk8s (v1.25.0+)`
- `juju (3.1.0+)`
- `terraform (1.5.0+)`
- [`pre-commit`](https://pre-commit.com/)

## Developing

### Terraform provider

The Terraform module uses the Juju provider to provision Juju resources.
Please refer to
the [Juju provider documentation](https://registry.terraform.io/providers/juju/juju/latest/docs)
for more information.

A Terraform working directory needs to be initialized at the beginning.

```shell
terraform init
```

## Testing

Terraform CLI provides various ways to do formatting and validation.

```shell
# Formats to a canonical format and style
$ terraform fmt

# Checks syntactical validation
$ terraform validate

# Preview the changes
$ terraform plan
```

An external linter (e.g. [tflint](https://github.com/terraform-linters/tflint))
also can be installed and used.

This repository also applies [`pre-commit` framework](https://pre-commit.com/)
to enforce git commit quality check. Various hooks will be run before the commit
is submitted.

```shell
# Install pre-commit hooks
$ pre-commit install

# Run individual hook manually
$ pre-commit run <hook>
```

## Commits Convention

Please follow
the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) to
create commit messages. This facilitates the usage of the
[Release Please Action](https://github.com/google-github-actions/release-please-action)
for automated releases of the Terraform module.

## Releasing

This repository leverages
the [release-please GitHub action](https://github.com/google-github-actions/release-please-action)
to help release. After releasing a new version of the module, create a merge
request to update
the [module version](https://git.launchpad.net/canonical-terraform-plans/tree/identity/environments/staging/main.tf#n2)
in
the [canonical-terraform-plans](https://launchpad.net/canonical-terraform-plans)
launchpad repository. Invite the IS team to review and merge the changes.
