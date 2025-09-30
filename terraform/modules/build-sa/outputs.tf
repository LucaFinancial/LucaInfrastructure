output "service_account_email" {
    description = "The email of the created service account"
    value       = google_service_account.this.email
}

output "service_account_name" {
    description = "The resource name of the service account"
    value       = google_service_account.this.name
}

output "service_account_unique_id" {
    description = "The unique id of the service account"
    value       = google_service_account.this.unique_id
}