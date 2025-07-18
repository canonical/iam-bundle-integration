data "juju_model" "this" {
  name = var.model
}

resource "juju_offer" "kratos_info_offer" {
  name             = "kratos-info-offer"
  model            = data.juju_model.this.name
  application_name = module.kratos.app_name
  endpoints        = ["kratos-info"]
}
