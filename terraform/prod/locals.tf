locals {
  env        = "prod"
  project_id = "luca-ledger-devops-prod"
  region     = "us-central1"

  # GCS Variables
  service_account_name_gcs = "ll-prod-build-sa-gcs"
  service_name_gcs         = "ll-prod-webapp-gcs"
  
  # Cloud Run Variables
  service_account_name_cloudrun = "ll-prod-build-sa-cloudrun"
  service_name_cloudrun         = "luca-ledger-webapp-prod"
  
  # Build Configuration
  branch_pattern = "^main$"
  
  # Storage
  bucket_name = "luca-ledger-devops-prod-webapp"
  
  # Cloud Run Configuration
  cloudrun_repository_id = "luca-ledger-webapp"
  
  # SSL/Domain Configuration
  ssl_domains_gcs = ["gcs.lucaledger.app"]
  ssl_domains_cloudrun = ["lucaledger.app", "run.lucaledger.app"]
}