# module "webapp-cloud-run" {
#   source = "../services/webapp-cloud-run"

#   env             = local.env
#   project_id      = local.project_id
#   region          = local.region
#   branch_pattern  = local.branch_pattern

#   service_name          = "lucaledger-dev-webapp-run"
#   service_account_name  = "ll-dev-build-sa-cloudrun"
#   trigger_name          = "lucaledger-dev-run"
#   ssl_domains           = ["run-dev.lucaledger.app"]
#   repository_id         = "lucaledger-dev-run"
# }

module "webapp-gcs" {
  source = "../services/webapp-gcs"

  env             = local.env
  project_id      = local.project_id
  region          = local.region
  branch_pattern  = local.branch_pattern

  service_name          = "lucaledger-dev-webapp-gcs"
  service_account_name  = "build-sa-gcs"
  bucket_name           = "lucaledger-dev-webapp"
  trigger_name          = "lucaledger-dev-gcs"
  ssl_domains           = ["dev.lucaledger.app"]
}

module "webapp-gcs-v1-beta" {
  source = "../services/webapp-gcs"

  env         = local.env
  project_id  = local.project_id
  region      = local.region

  service_name          = "lucaledger-dev-gcs-v1-beta"
  service_account_name  = "build-sa-gcs-v1-beta"
  branch_pattern        = "v1/*"
  bucket_name           = "lucaledger-dev-v1-beta"
  trigger_name          = "lucaledger-dev-v1-beta"
  ssl_domains           = ["v1-beta.lucaledger.app"]
}

module "webapp-gcs-v2-beta" {
  source = "../services/webapp-gcs"

  env         = local.env
  project_id  = local.project_id
  region      = local.region

  service_name          = "lucaledger-dev-gcs-v2-beta"
  service_account_name  = "build-sa-gcs-v2-beta"
  branch_pattern        = "release/v-2-0-0"
  bucket_name           = "lucaledger-dev-v2-beta"
  trigger_name          = "lucaledger-dev-v2-beta"
  ssl_domains           = ["v2-beta.lucaledger.app"]
}
