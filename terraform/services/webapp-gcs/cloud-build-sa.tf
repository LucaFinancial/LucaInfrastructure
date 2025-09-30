# Cloud Build Service Account for GCS deployment
module "cloud_build_sa" {
  source = "../../modules/cloud-build-sa"

  project_id           = var.project_id
  service_account_name = var.service_account_name_gcs
  display_name         = "Cloud Build Service Account for GCS"
  description          = "Service account for Cloud Build operations deploying to GCS"

  # GCS-specific additional roles beyond the base Cloud Build permissions
  additional_project_roles = []
}

# GCS-specific bucket permissions (handled outside the generic module)
resource "google_storage_bucket_iam_member" "cloud_build_sa_object_admin" {
  bucket = var.bucket_name
  role   = "roles/storage.objectAdmin"
  member = module.cloud_build_sa.service_account_email

  depends_on = [module.cloud_build_sa, google_storage_bucket.luca_ledger_web_app_bucket]
}
