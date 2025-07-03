
resource "juju_offer" "kratos_info_offer" {
  name             = "kratos-info-offer"
  model            = var.model
  application_name = module.kratos.app_name
  endpoints        = ["kratos-info"]
}
