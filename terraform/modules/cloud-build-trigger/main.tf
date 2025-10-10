locals {
  # Combine default included files with the cloudbuild file
  all_included_files = concat(
    var.included_files,
    [var.cloudbuild_filename]
  )
}

resource "google_cloudbuild_trigger" "webapp_trigger" {
  name        = var.trigger_name
  description = var.trigger_description
  disabled    = false
  project     = var.project_id
  location    = var.region
  
  included_files = local.all_included_files

  github {
    owner = var.github_owner
    name  = var.github_repo
    push {
      branch = var.branch_pattern
    }
  }

  substitutions = var.substitutions

  filename = var.cloudbuild_filename
  
  service_account = "projects/${var.project_id}/serviceAccounts/${var.service_account_email}"
}