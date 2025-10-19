output "repository_url" {
  description = "The URL of the Artifact Registry repository"
  value = "https://${var.region}-docker.pkg.dev/${var.project_id}/${var.repository_id}"
}

output "cloud_build_sa_email" {
  description = "The email of the Cloud Build service account"
  value = module.cloud_build_sa.service_account_email
}

output "cloudrun_runtime_sa_email" {
  description = "The email of the Cloud Run runtime service account"
  value = google_service_account.cloudrun_runtime_sa.email
}