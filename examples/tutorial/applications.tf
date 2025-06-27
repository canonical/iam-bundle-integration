module "iam" {
  source = "../../"
  model  = juju_model.iam.name

  postgresql_offer_url          = module.core.postgresql_offer_url
  ingress_offer_url             = module.core.ingress_offer_url
  send_ca_certificate_offer_url = module.core.send_ca_certificate_offer_url

  hydra                    = var.hydra
  kratos                   = var.kratos
  login_ui                 = var.login_ui
  admin_ui                 = var.admin_ui
  openfga                  = var.openfga
  idp_provider_config      = var.idp_provider_config
  idp_provider_credentials = var.idp_provider_credentials
}
