module "web-app-gcs" {
  source = "../modules/web-app-gcs"

  env           = var.env
  project_id    = var.project_id
  region        = var.region

  service_account_name_gcs = "cloud-build-sa-gcs"
  service_name_gcs  = "luca-ledger-prod-web-app-gcs"

  branch_pattern  = ".*"
  bucket_name     = "luca-ledger-prod-web-app"

  ssl_domains = ["lucaledger.app"]
}
