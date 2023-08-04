# How to Deploy to ProdStack 6 Cloud

## Prerequisites

Before deploying the Identity Platform Juju Bundle Terraform module to ProdStack
6 Cloud, you need to prepare the followings:

- A service environment has been provisioned in the ProdStack 6 Cloud. If not,
  please refer to [this section](#how-to-deploy-a-service-environment).
- Submit [a request to IS for SSH key update](https://portal.admin.canonical.com/requests/new)
and invite two team member to approve it.
- Set up and connect to the
  company-wide [VPN](https://wiki.canonical.com/InformationInfrastructure/IS/HowTo/CompanyOpenVPN).

## How to deploy the module

### Deploy the module

IS team provisioned a bastion server for Identity team to use for accessing the
service environment.
You can use the generated ssh private key to log into the server by running the
following command:

```shell
$ ssh -i <path-to-private-key> <username>@identity-bastion-ps6.internal
```

**Note:** the username should be your launchpad id.

Once you logged in, list all the service environments created using the
following command:

```shell
$ pe -n

sudo -iu stg-iam-bundle se stg-iam-bundle # (0) [LIVE][PS6][K8S] Testing environment for IAM bundle
```

Run the following to switch to the target service environment:

```shell
$ pe stg-iam-bundle

This model is managed by Terraform. Please don't make manual changes using
the Juju CLI except in an emergency.

This environment is defined by plan: "placeholder/environments/stg"

To use Terraform, run:

  cd ~/plan && git pull
  load_creds s3
  terraform plan

See https://wiki.canonical.com/InformationInfrastructure/IS/Terraform
for more details.
```

Initialize the remote Terraform backend for the module. **Note:** You don't
need to run the following command unless this is the first time that the module
is to be deployed.

```shell
$ bootstrap_backend
```

As per the outputs of the `pe` command above, run the following commands:

```shell
# Fetch the latest canonical-terraform-plans repository if necessary
$ cd ~/plan && git pull

# Load the credentials for the S3 bucket from Vault server
$ load_creds s3
```

Prepare a Terraform variable definition (`.tfvars`) file if not exists:

```shell
# vars.tfvars
model = <juju model, e.g. 'stg-iam-bundle'>

cloud = {
  name   = <cloud name, e.g. 'k8s-stg-general'>
  region = <region name, e.g. 'default'>
}

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

> :rotating_light: **Note:**
>
> - A variable file had been created in the home directory,
    e.g. `/home/stg-iam-bundle/vars.tfvars`. Make changes if necessary.
> - There is no secret management solution yet to allow users to manage their
    own secrets.

Then run the following commands to deploy:

```shell
# Initialize the working directory
$ https_proxy=http://squid.internal:3128 NO_PROXY=radosgw.ps6.canonical.com terraform init

# Create and preview an execution plan
$ terraform plan -var-file=<path-to-var-file>

# Execute the plan
$ terraform apply -var-file=<path-to-var-file>
```

Monitor the status of the deployment:

```shell
$ watch -n1 juju status --relations
```

### Clean up

If you no longer need the deployed module, run the following command to clean up
the provisioned resources:

```shell
$ terraform destroy
```

## How to deploy a service environment

If a new service environment is needed, you need to make changes to the root
module where the service environments used by Identity team are declared. Use
the [service_environment](https://git.launchpad.net/canonical-terraform-modules/tree/prodstack/common/service_environment/README.md)
Terraform module to create a service environment. Create a merge request and
invite the IS team to review and deploy it.

```shell
$ git clone lp:canonical-terraform-plans

$ cd prodstack/ps6/environments/identity/<stage, e.g. 'staging' or 'production'>

$ vim main.tf
```

## References

- [Canonical Terraform Plans](https://launchpad.net/canonical-terraform-plans)
- [Canonical Terraform Modules](https://launchpad.net/canonical-terraform-modules)
