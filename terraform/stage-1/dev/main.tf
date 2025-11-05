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
