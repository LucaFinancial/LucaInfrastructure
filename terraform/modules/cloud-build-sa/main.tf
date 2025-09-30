locals {
  base_roles = [
    "roles/cloudbuild.builds.builder",
    "roles/logging.logWriter"
  ]
}

resource "google_service_account" "cloud_build_sa" {
  project      = var.project_id
  account_id   = var.service_account_name
  display_name = var.display_name
  description  = var.description
}

resource "google_project_iam_member" "cloud_build_sa_roles" {
  for_each = toset(concat(local.base_roles, var.additional_project_roles))
  
  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.cloud_build_sa.email}"
}