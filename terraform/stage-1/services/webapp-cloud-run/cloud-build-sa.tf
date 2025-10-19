module "cloud_build_sa" {
  source = "../../modules/cloud-build-sa"

  project_id           = var.project_id
  service_account_name = var.service_account_name
  display_name         = "Cloud Build Service Account for Cloud Run - ${title(var.env)}"
  description          = "Service account for Cloud Build operations for Cloud Run deployment in ${var.env} environment"

  additional_project_roles = [
    "roles/run.admin",
    "roles/artifactregistry.writer",
    "roles/storage.admin"
  ]
}