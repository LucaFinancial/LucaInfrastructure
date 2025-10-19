module "webapp-gcs" {
  source = "../services/webapp-gcs"

  env           = local.env
  project_id    = local.project_id
  region        = local.region
  branch_pattern = local.branch_pattern

  service_name         = "ll-prod-webapp-gcs"
  service_account_name = "ll-prod-build-sa-gcs"
  bucket_name    = "luca-ledger-devops-prod-webapp"
  trigger_name   = "lucaledger-prod-gcs"
  ssl_domains = ["gcs.lucaledger.app", "lucaledger.app"]
}

module "webapp-v1" {
  source = "../services/webapp-gcs"

  env         = local.env
  project_id  = local.project_id
  region      = local.region

  service_name          = "lucaledger-prod-webapp-v1"
  service_account_name  = "build-sa-v1"
  branch_pattern        = "release/v1"
  bucket_name           = "lucaledger-prod-webapp-v1"
  trigger_name          = "lucaledger-prod-v1"
  ssl_domains           = ["v1.lucaledger.app"]
}

module "webapp-cloud-run" {
  source = "../services/webapp-cloud-run"

  env            = local.env
  project_id     = local.project_id
  region         = local.region
  branch_pattern = local.branch_pattern

  service_name          = "lucaledger-prod-webapp-run"
  service_account_name  = "ll-prod-build-sa-cloudrun"
  trigger_name          = "lucaledger-prod-run"
  ssl_domains           = ["run.lucaledger.app"]
  repository_id         = "lucaledger-prod-run"
}
