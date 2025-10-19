variable "project_id" {
  description = "The GCP project ID where the service account will be created"
  type        = string
}

variable "service_account_name" {
  description = "The account ID for the service account (must be unique within project)"
  type        = string
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.service_account_name))
    error_message = "Service account name must be 6-30 characters, start with lowercase letter, and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "display_name" {
  description = "The display name for the service account"
  type        = string
}

variable "description" {
  description = "A description of the service account"
  type        = string
  default     = "Service account for Cloud Build operations"
}

variable "additional_project_roles" {
  description = "Additional project-level IAM roles to assign to the service account beyond the base Cloud Build roles"
  type        = list(string)
  default     = []
  validation {
    condition = alltrue([
      for role in var.additional_project_roles : can(regex("^roles/", role))
    ])
    error_message = "All roles must start with 'roles/' prefix."
  }
}