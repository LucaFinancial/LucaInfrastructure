resource "google_cloudbuild_trigger" "luca_ledger_web_app_gcs" {
  name        = "luca-ledger-${var.env}-web-app-trigger-gcs"
  description = "Trigger for deploying the Luca Ledger web app to GCS (dev)"
  disabled    = false
  project     = var.project_id
  location    = var.region
  
  included_files = [
    "src/**",
    "package.json",
    "vite.config.*",
    "yarn.lock",
    "cloudbuild.yml"
  ]

  github {
    owner = "LucaFinancial"
    name  = "LucaLedger"
    push {
      branch = var.branch_pattern
    }
  }

  substitutions = {
    _BUCKET_NAME = var.bucket_name
  }

  filename = "cloudbuild.gcs.yml"
  
  service_account = "projects/${var.project_id}/serviceAccounts/${module.cloud_build_sa.service_account_email}"

  depends_on = [module.cloud_build_sa, google_storage_bucket.luca_ledger_web_app_bucket]
}