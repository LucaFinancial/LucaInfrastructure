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


# module "cloud_build_trigger" {
  # source = "../../modules/cloud-build-trigger"

  # env                   = var.env
  # project_id            = var.project_id
  # region                = var.region

  # trigger_name          = var.trigger_name
  # trigger_description   = "Trigger for deploying the Luca Ledger web app to Cloud Run (${var.env})"
  # cloudbuild_filename   = "cloudbuild.cloudrun.yml"
  # branch_pattern        = var.branch_pattern
  
  # service_account_email = module.cloud_build_sa.service_account_email

  # substitutions = {
    # _ENVIRONMENT    = var.env
    # _SERVICE_NAME   = var.service_name
    # _REGION         = var.region
    # _REPOSITORY_URL = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repository_id}"
  # }

  # depends_on = [
    # module.cloud_build_sa,
    # google_artifact_registry_repository.luca_ledger_container_registry
  # ]
# }
