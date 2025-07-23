resource "google_service_account" "cloud_build_sa_gcs" {
  project      = var.project_id
  account_id   = var.service_account_name_gcs
  display_name = "Cloud Build Service Account for GCS"
}

resource "google_project_iam_member" "cloudbuild_sa_iam_user" {
  project = var.project_id
  role   = "roles/iam.serviceAccountUser"
  member = "serviceAccount:${var.service_account_name_gcs}@${var.project_id}.iam.gserviceaccount.com"
}

resource "google_storage_bucket_iam_member" "cloudbuild_sa_object_admin" {
  bucket  = var.bucket_name
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${var.service_account_name_gcs}@${var.project_id}.iam.gserviceaccount.com"

  depends_on = [google_storage_bucket.luca_ledger_web_app_bucket]
}

resource "google_project_iam_member" "cloudbuild_sa_builder" {
  project = var.project_id
  role    = "roles/cloudbuild.builds.builder"
  member  = "serviceAccount:${var.service_account_name_gcs}@${var.project_id}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "cloudbuild_sa_logging" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${var.service_account_name_gcs}@${var.project_id}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "cloudbuild_cloud_run_deployer" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${var.service_account_name_gcs}@${var.project_id}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "cloudbuild_artifact_registry_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${var.service_account_name_gcs}@${var.project_id}.iam.gserviceaccount.com"
}
