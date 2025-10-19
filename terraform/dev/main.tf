module "webapp-cloud-run" {
  source = "../services/webapp-cloud-run"

  env             = local.env
  project_id      = local.project_id
  region          = local.region
  branch_pattern  = local.branch_pattern

  service_name          = "luca-ledger-dev-webapp-run"
  service_account_name  = "build-sa-cloudrun"
  trigger_name          = "luca-ledger-dev-webapp-trigger-run"
  ssl_domains           = ["run-dev.lucaledger.app"]
  repository_id         = "luca-ledger-dev-webapp-run"
}

module "webapp-gcs" {
  source = "../services/webapp-gcs"

  env             = local.env
  project_id      = local.project_id
  region          = local.region
  branch_pattern  = local.branch_pattern

  service_name          = "luca-ledger-dev-webapp-gcs"
  service_account_name  = "build-sa-gcs"
  bucket_name           = "luca-ledger-dev-webapp"
  trigger_name          = "luca-ledger-dev-webapp-trigger-gcs"
  ssl_domains           = ["gcs-dev.lucaledger.app", "dev.lucaledger.app"]
}

module "webapp-gcs-v1-beta" {
  source = "../services/webapp-gcs"

  env         = local.env
  project_id  = local.project_id
  region      = local.region

  service_name          = "dev-webapp-gcs-v1-beta"
  service_account_name  = "build-sa-gcs-v1-beta"
  branch_pattern        = "release/v-1-9-5"
  bucket_name           = "lucaledger-dev-webapp-v1-beta"
  trigger_name          = "webapp-trigger-gcs-v1-beta"
  ssl_domains           = ["v1-beta.lucaledger.app"]
}

module "webapp-gcs-v2-beta" {
  source = "../services/webapp-gcs"

  env         = local.env
  project_id  = local.project_id
  region      = local.region

  service_name          = "dev-webapp-gcs-v2-beta"
  service_account_name  = "build-sa-gcs-v2-beta"
  branch_pattern        = "release/v-2-0-0"
  bucket_name           = "luca-ledger-dev-webapp-v2-beta"
  trigger_name          = "webapp-trigger-gcs-v2-beta"
  ssl_domains           = ["v2-beta.lucaledger.app"]
}
