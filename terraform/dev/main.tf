module "webapp-gcs" {
  source = "../services/webapp-gcs"

  env           = local.env
  project_id    = local.project_id
  region        = local.region

  service_account_name_gcs = local.service_account_name_gcs
  service_name_gcs         = local.service_name_gcs

  branch_pattern = local.branch_pattern
  bucket_name    = local.bucket_name

  ssl_domains = ["gcs.dev.lucaledger.app"]
}

  # GCS
  service_account_name_gcs  = "build-sa-gcs"
  service_name_gcs          = "luca-ledger-devops-dev-webapp-gcs"
  bucket_name               = "luca-ledger-devops-dev-webapp"
  ssl_domains_gcs           = 

  # Cloud Run
  service_account_name_cloudrun = 
  service_name_cloudrun         = 
  cloudrun_repository_id        = "luca-ledger-devops-dev-webapp-run"
  ssl_domains_cloudrun          = 
module "webapp-cloud-run" {
  source = "../services/webapp-cloud-run"
  
  service_name = "luca-ledger-devops-dev-webapp"

  env             = local.env
  project_id      = local.project_id
  region          = local.region
  branch_pattern  = local.branch_pattern

  service_account_name = "luca-ledger-devops-dev-build-sa-cloudrun"

  repository_id  = local.cloudrun_repository_id

  ssl_domains = ["run.dev.lucaledger.app", "dev.lucaledger.app"]
}
