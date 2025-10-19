resource "google_cloudbuild_trigger" "luca_ledger_web_app_gcs" {
  name        = var.trigger_name
  description = "Trigger for deploying the Luca Ledger web app to Cloud Run (dev)"
  disabled    = false
  project     = var.project_id
  location    = "global"
  
  included_files = [
    "src/**",
    "package.json",
    "vite.config.*",
    "yarn.lock",
    "cloudbuild.cloudrun.yml"
  ]

  github {
    owner = "LucaFinancial"
    name  = "LucaLedger"
    push {
      branch = var.branch_pattern
    }
  }

  substitutions = {
    _ENVIRONMENT    = var.env
    _SERVICE_NAME   = var.service_name
    _REGION         = var.region
    _REPOSITORY_URL = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repository_id}"
  }

  filename = "cloudbuild.cloudrun.yml"
  
  service_account = "projects/${var.project_id}/serviceAccounts/${module.cloud_build_sa.service_account_email}"

  depends_on = [module.cloud_build_sa]
}
