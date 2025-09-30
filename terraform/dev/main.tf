module "webapp-gcs" {
  source = "../modules/webapp-gcs"

  env           = var.env
  project_id    = var.project_id
  region        = var.region

  service_account_name_gcs = "cloud-build-sa-gcs"
  service_name_gcs  = "luca-ledger-dev-webapp-gcs"

  branch_pattern  = ".*"
  bucket_name     = "luca-ledger-devops-dev-webapp"

  ssl_domains = ["gcs.dev.lucaledger.app"]
}
