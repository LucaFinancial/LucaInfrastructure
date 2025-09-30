locals {
  env        = "dev"
  project_id = "luca-ledger-devops-dev"
  region     = "us-central1"

  # Service Account and Service Names
  service_account_name_gcs = "build-sa-gcs"
  service_name_gcs         = "luca-ledger-devops-dev-webapp-gcs"

  # Build Configuration
  branch_pattern = ".*"

  # Storage
  bucket_name = "luca-ledger-devops-dev-webapp"

  # SSL/Domain Configuration
  ssl_domains = ["gcs.dev.lucaledger.app"]
}