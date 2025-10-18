module "cloud_build_sa" {
  source = "../../modules/cloud-build-sa"

  project_id           = var.project_id
  service_account_name = var.service_account_name
  display_name         = "Cloud Build Service Account for GCS"
  description          = "Service account for Cloud Build operations deploying to GCS"

  additional_project_roles = ["roles/storage.objectAdmin"]
}
