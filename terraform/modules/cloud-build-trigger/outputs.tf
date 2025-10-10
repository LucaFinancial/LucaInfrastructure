output "trigger_id" {
  description = "The ID of the created Cloud Build trigger"
  value       = google_cloudbuild_trigger.webapp_trigger.id
}

output "trigger_name" {
  description = "The name of the created Cloud Build trigger"
  value       = google_cloudbuild_trigger.webapp_trigger.name
}