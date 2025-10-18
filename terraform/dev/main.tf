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
