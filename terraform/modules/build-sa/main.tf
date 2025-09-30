resource "google_service_account" "this" {
    project     = var.project
    account_id  = var.account_id
    display_name = length(trim(var.display_name)) > 0 ? var.display_name : var.account_id
    description = var.description
    disabled    = var.disabled
    labels      = var.labels
}