locals {
  account_id   = "build-sa-${var.service_name}-${var.environment}"
  display_name = "${title(var.service_name)} Build Service Account (${upper(var.environment)})"
  
  # Default description if none provided
  description = var.description != null ? var.description : "Service account for ${var.service_name} in ${var.environment} environment"
  
  # Organizational standard labels
  default_labels = {
    environment = var.environment
    service     = var.service_name
    managed-by  = "terraform"
    module      = "build-sa"
  }
  
  labels = merge(local.default_labels, var.additional_labels)
  
  # Default build roles + any additional ones
  default_roles = [
    "roles/cloudbuild.builds.builder",
    "roles/iam.serviceAccountUser",
    "roles/storage.admin"
  ]
  
  final_roles = concat(local.default_roles, var.additional_roles)
}

resource "google_service_account" "build_sa" {
  project      = var.project
  account_id   = local.account_id
  display_name = local.display_name
  description  = local.description
  disabled     = false
  labels       = local.labels
}

resource "google_project_iam_member" "build_sa_roles" {
    for_each = toset(local.final_roles)

    project = var.project
    role    = each.value
    member  = "serviceAccount:${google_service_account.build_sa.email}"
}