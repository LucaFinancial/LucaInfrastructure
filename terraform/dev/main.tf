module "web-app-gcs" {
  source = "../modules/web-app-gcs"

  env           = var.env
  project_id    = var.project_id
  region        = var.region

  service_account_name_gcs = "cloud-build-sa-gcs"
  service_name_gcs  = "luca-ledger-dev-web-app-gcs"

  branch_pattern  = ".*"
  bucket_name     = "luca-ledger-dev-web-app"

  ssl_domains = ["dev.lucaledger.app"]
}

#module "web-app-cloud-run" {}
