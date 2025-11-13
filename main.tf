data "juju_model" "this" {
  uuid = var.model
}

resource "juju_offer" "kratos_info_offer" {
  name             = "kratos-info-offer"
  application_name = module.kratos.app_name
  endpoints        = ["kratos-info"]
  model_uuid       = data.juju_model.this.uuid
}
