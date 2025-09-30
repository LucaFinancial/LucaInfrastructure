module "cloud_build_sa" {
  source = "../../modules/cloud-build-sa"

  project_id           = var.project_id
  service_account_name = var.service_account_name_gcs
  display_name         = "Cloud Build Service Account for GCS"
  description          = "Service account for Cloud Build operations deploying to GCS"

  additional_project_roles = []
}

resource "google_storage_bucket_iam_member" "cloud_build_sa_object_admin" {
  bucket = var.bucket_name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${module.cloud_build_sa.service_account_email}"
}
