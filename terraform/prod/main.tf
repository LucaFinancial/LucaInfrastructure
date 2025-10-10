module "webapp-gcs" {
  source = "../services/webapp-gcs"

  env           = local.env
  project_id    = local.project_id
  region        = local.region

  service_account_name_gcs = local.service_account_name_gcs
  service_name_gcs         = local.service_name_gcs
  branch_pattern = local.branch_pattern
  bucket_name    = local.bucket_name
  ssl_domains = local.ssl_domains_gcs
}

module "webapp-cloud-run" {
  source = "../services/webapp-cloud-run"

  env           = local.env
  project_id    = local.project_id
  region        = local.region

  service_account_name_cloudrun = local.service_account_name_cloudrun
  service_name_cloudrun         = local.service_name_cloudrun

  branch_pattern = local.branch_pattern
  repository_id  = local.cloudrun_repository_id

  ssl_domains = local.ssl_domains_cloudrun
}
