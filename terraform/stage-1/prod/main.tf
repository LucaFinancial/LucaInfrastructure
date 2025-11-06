module "webapp-gcs" {
  source = "../services/webapp-gcs"

  env           = local.env
  project_id    = local.project_id
  region        = local.region

  service_name          = "ll-prod-webapp-gcs"
  service_account_name  = "ll-prod-build-sa-gcs"
  branch_pattern        = "^prepare-v2-release$"
  bucket_name           = "luca-ledger-devops-prod-webapp"
  trigger_name          = "lucaledger-prod-gcs"
  ssl_domains           = ["lucaledger.app"]
}

module "webapp-v1" {
  source = "../services/webapp-gcs"

  env         = local.env
  project_id  = local.project_id
  region      = local.region

  service_name          = "lucaledger-prod-webapp-v1"
  service_account_name  = "build-sa-v1"
  branch_pattern        = "^release/v1$"
  bucket_name           = "lucaledger-prod-webapp-v1"
  trigger_name          = "lucaledger-prod-v1"
  ssl_domains           = ["v1.lucaledger.app"]
}

module "webapp-v2" {
  source = "../services/webapp-gcs"

  env         = local.env
  project_id  = local.project_id
  region      = local.region

  service_name          = "lucaledger-prod-webapp-v2"
  service_account_name  = "build-sa-v2"
  branch_pattern        = "^main$"
  bucket_name           = "lucaledger-prod-webapp-v2"
  trigger_name          = "lucaledger-prod-v2"
  ssl_domains           = ["beta.lucaledger.app"]
}
