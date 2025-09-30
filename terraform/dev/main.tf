module "webapp-gcs" {
  source = "../services/webapp-gcs"

  env           = local.env
  project_id    = local.project_id
  region        = local.region

  service_account_name_gcs = local.service_account_name_gcs
  service_name_gcs         = local.service_name_gcs

  branch_pattern = local.branch_pattern
  bucket_name    = local.bucket_name

  ssl_domains = local.ssl_domains
}
