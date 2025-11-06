resource "juju_offer" "postgresql_offer" {
  model            = juju_model.core.name
  name             = "postgresql"
  application_name = module.postgresql.application_name
  endpoints        = ["database"]
}

