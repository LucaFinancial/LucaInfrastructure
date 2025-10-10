resource "google_artifact_registry_repository" "luca_ledger_container_registry" {
  location      = var.region
  repository_id = var.repository_id
  description   = var.repository_description
  format        = "DOCKER"
  project       = var.project_id
}