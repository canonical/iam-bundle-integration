# Tutorial: Deploying Identity SAML Provider with Terraform

This tutorial guides you through deploying the **Identity SAML Provider** (built
using the `identity-saml-provider-operator` charm) and integrating it with the
**Identity Platform Juju Bundle** (which includes Ory Hydra, Ory Kratos, and
the Identity Platform Login UI) using Terraform and the Juju provider.

The Identity SAML Provider acts as a SAML-to-OIDC bridge, enabling traditional
SAML Service Providers (SPs) to authenticate seamlessly against the modern
OIDC-based Single Sign-On (SSO) engine provided by Ory Hydra.

---

## Architecture Overview

By the end of this tutorial, you will have two Juju models deployed:

1. **`core` Model**: Hosts central dependencies including:
   - **PostgreSQL**: Used for database storage by Kratos, Hydra, and the SAML
     Provider.
   - **Traefik Public**: Manages ingress and routing.
   - **Self-Signed Certificates**: Offers secure TLS communication.
2. **`iam` Model**: Hosts the identity services:
   - **Identity Platform Bundle**: Ory Kratos, Ory Hydra, and Login UI.
   - **Identity SAML Provider**: Bridged with Hydra over the `oauth` interface
     and PostgreSQL over the `database` interface.

```mermaid
graph TD
    subgraph "Core Model"
        DB[(PostgreSQL)]
        Ingress[Traefik Ingress]
        Certs[Certificates]
    end

    subgraph "IAM Model"
        Hydra[Ory Hydra]
        Kratos[Ory Kratos]
        SAML[Identity SAML Provider]
        LoginUI[Login UI]
    end

    SAML -- "database" --> DB
    SAML -- "public-route" --> Ingress
    SAML -- "oauth" --> Hydra
    Hydra -- "database" --> DB
    Kratos -- "database" --> DB
    LoginUI -- "public-route" --> Ingress
```

---

## Step-by-Step Deployment

### Step 1: Generate SAML Credentials

The Identity SAML Provider requires a public certificate and a private key to
sign SAML assertions.

Generate a self-signed keypair using OpenSSL:

```shell
# Generate the private key
openssl genrsa -out saml.key 2048

# Generate the self-signed public certificate
openssl req -new -x509 -key saml.key -out saml.crt -days 365 -subj "/CN=identity-saml-provider"
```

---

### Step 2: Configure Terraform Variables

Create a `terraform.tfvars` file in the same directory as this tutorial
(`examples/saml-provider/`) to supply the certificate, key, and configurations.

We manage Juju secrets natively within Terraform. Supply the generated cert and
key contents as sensitive variables:

```hcl
# terraform.tfvars

# The SAML public-cert and private-key contents generated in Step 1
saml_public_cert = <<EOF
-----BEGIN CERTIFICATE-----
MIIDXTCCAkSgAwIBAgIUdG...
-----END CERTIFICATE-----
EOF

saml_private_key = <<EOF
-----BEGIN MOCK PRIVATE KEY-----
MIIEowIBAAKCAQEA09W...
-----END MOCK PRIVATE KEY-----
EOF

# Configuration for the SAML provider application
identity_saml_provider = {
  name    = "identity-saml-provider"
  channel = "latest/stable"
  base    = "ubuntu@24.04"
  config  = {
    dev = "false"
  }
}
```

---

### Step 3: Initialize and Deploy

Deploy the entire stack with Terraform. Terraform will automatically handle
creating Juju models, creating Juju user-secrets, and granting the application
access to those secrets:

```shell
# Initialize the Terraform working directory
terraform init

# Plan and preview the deployment
terraform plan -var-file="terraform.tfvars"

# Deploy the stack
terraform apply -var-file="terraform.tfvars"
```

Type `yes` when prompted to confirm the execution.

---

### Step 4: Verify Deployment Status

The deployment will take several minutes as Juju provisions container
resources, retrieves OCI images, and configures relations. You can monitor the
status using:

```shell
watch -n 1 juju status -m iam --relations
```

Once deployment is complete, all applications (including
`identity-saml-provider`) should list their status as `active` and agent
status as `idle`.

---

## Clean Up

To tear down all resources, models, and relations created during this
tutorial, simply run:

```shell
terraform destroy -var-file="terraform.tfvars"
```
