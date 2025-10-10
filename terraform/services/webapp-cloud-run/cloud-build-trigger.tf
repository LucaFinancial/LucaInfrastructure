module "cloud_build_trigger" {
  source = "../../modules/cloud-build-trigger"

  project_id            = var.project_id
  region                = var.region
  trigger_name          = "luca-ledger-cloudrun-${var.env}-trigger"
  trigger_description   = "Trigger for deploying the Luca Ledger web app to Cloud Run (${var.env})"
  cloudbuild_filename   = "cloudbuild.cloudrun.yml"
  branch_pattern        = var.branch_pattern
  
  service_account_email = module.cloud_build_sa.service_account_email

  substitutions = {
    _ENVIRONMENT    = var.env
    _SERVICE_NAME   = var.service_name_cloudrun
    _REGION         = var.region
    _REPOSITORY_URL = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repository_id}"
  }

  depends_on = [
    module.cloud_build_sa,
    google_artifact_registry_repository.luca_ledger_container_registry
  ]
}
