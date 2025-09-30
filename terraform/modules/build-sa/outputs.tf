output "service_account_email" {
    description = "The email address of the service account"
    value       = google_service_account.build_sa.email
}

output "service_account_name" {
    description = "The fully-qualified resource name of the service account"
    value       = google_service_account.build_sa.name
}

output "service_account_id" {
    description = "The account_id portion of the service account (before @)"
    value       = google_service_account.build_sa.account_id
}

output "service_account_unique_id" {
    description = "The unique numeric ID assigned by Google Cloud"
    value       = google_service_account.build_sa.unique_id
}
