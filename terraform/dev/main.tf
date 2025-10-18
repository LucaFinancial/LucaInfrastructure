module "webapp-gcs" {
  source = "../services/webapp-gcs"

  env         = local.env
  project_id  = local.project_id
  region      = local.region

  service_account_name  = "build-sa-gcs"
  service_name          = "luca-ledger-devops-dev-webapp-gcs"
  branch_pattern        = local.branch_pattern
  bucket_name           = "luca-ledger-devops-dev-webapp"
  ssl_domains           = ["gcs-dev.lucaledger.app"]
}

module "webapp-cloud-run" {
  source = "../services/webapp-cloud-run"

  env         = local.env
  project_id  = local.project_id
  region      = local.region

  service_name          = "luca-ledger-devops-dev-webapp-run"
  service_account_name  = "luca-ledger-devops-dev-build-sa-cloudrun"
  branch_pattern        = local.branch_pattern
  repository_id         = "luca-ledger-devops-dev-webapp-run"
  ssl_domains           = ["run-dev.lucaledger.app"]
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