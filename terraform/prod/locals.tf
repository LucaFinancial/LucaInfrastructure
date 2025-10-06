locals {
  env        = "prod"
  project_id = "luca-ledger-devops-prod"
  region     = "us-central1"

  # GCS Variables
  service_account_name_gcs = "ll-prod-build-sa-gcs"
  service_name_gcs         = "ll-prod-webapp-gcs"
  branch_pattern = "^main$"
  bucket_name = "luca-ledger-devops-prod-webapp"
  ssl_domains = ["gcs.lucaledger.app", "lucaledger.app"]
}