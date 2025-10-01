locals {
  env        = "prod"
  project_id = "luca-ledger-devops-prod"
  region     = "us-central1"

  # GCS Variables
  service_account_name_gcs = "luca-ledger-devops-prod-build-sa-gcs"
  service_name_gcs         = "luca-ledger-devops-prod-webapp-gcs"
  branch_pattern = ".*"
  bucket_name = "luca-ledger-devops-prod-webapp"
  ssl_domains = ["gcs.lucaledger.app", "lucaledger.app"]
}