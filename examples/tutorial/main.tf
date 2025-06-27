resource "juju_model" "iam" {
  name = "iam"
}

module "core" {
  source = "../../"

  deploy_admin_ui = var.deploy_admin_ui
  deploy_kratos_external_idp_integrator = var.deploy_kratos_external_idp_integrator
  
  hydra = var.hydra
  kratos = var.kratos
  login_ui = var.login_ui
  admin_ui = var.admin_ui
  
  idp_provider_config = var.idp_provider_config
  idp_provider_credentials = var.idp_provider_credentials

  openfga_offer_url = "8b9830d6-6b9e-42a2-a1e0-75bd009c6c3e@serviceaccount/dev-core.openfga"
  postgresql_offer_url = "8b9830d6-6b9e-42a2-a1e0-75bd009c6c3e@serviceaccount/dev-core.postgresql"
  ingress_offer_url = "8b9830d6-6b9e-42a2-a1e0-75bd009c6c3e@serviceaccount/dev-core.ingress-ingress"
  send_ca_certificate_offer_url = "8b9830d6-6b9e-42a2-a1e0-75bd009c6c3e@serviceaccount/dev-core.send-ca-cert"

}
