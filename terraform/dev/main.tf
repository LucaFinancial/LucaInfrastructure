module "webapp-gcs" {
  source = "../services/webapp-gcs"

  env           = local.env
  project_id    = local.project_id
  region        = local.region

  service_account_name_gcs = local.service_account_name_gcs
  service_name_gcs         = local.service_name_gcs

  branch_pattern = local.branch_pattern
  bucket_name    = local.bucket_name
  trigger_name   = local.trigger_name

  ssl_domains = local.ssl_domains
}

module "webapp-gcs-v2-beta" {
  source = "../services/webapp-gcs"

  env           = local.env
  project_id    = local.project_id
  region        = local.region

  service_account_name_gcs = "build-sa-gcs-v2-beta"
  service_name_gcs         = "dev-webapp-gcs-v2-beta"

  branch_pattern = "release/v-2-0-0"
  bucket_name    = "luca-ledger-devops-dev-webapp-v2-beta"
  trigger_name   = "web-app-trigger-gcs-v2-beta"

  ssl_domains = ["v2-beta.lucaledger.app"]
}

module "webapp-gcs-v1-beta" {
  source = "../services/webapp-gcs"

  env           = local.env
  project_id    = local.project_id
  region        = local.region

  service_account_name_gcs = "build-sa-gcs-v1-beta"
  service_name_gcs         = "dev-webapp-gcs-v1-beta"

  branch_pattern = "release/v-1-9-5"
  bucket_name    = "luca-ledger-devops-dev-webapp-v1-beta"
  trigger_name   = "web-app-trigger-gcs-v1-beta"

  ssl_domains = ["v1-beta.lucaledger.app"]
}