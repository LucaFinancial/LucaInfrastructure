# Cloud Run runtime service account
resource "google_service_account" "cloudrun_runtime_sa" {
  project      = var.project_id
  account_id   = "cloudrun-runtime-sa-${var.env}"
  display_name = "Cloud Run Runtime Service Account - ${title(var.env)}"
  description  = "Service account used by Cloud Run service at runtime in ${var.env} environment"
}

# Basic roles for the runtime service account
resource "google_project_iam_member" "cloudrun_runtime_sa_roles" {
  for_each = toset([
    "roles/cloudsql.client",
    "roles/storage.objectViewer"
  ])
  
  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.cloudrun_runtime_sa.email}"
}
