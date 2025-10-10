variable "project_id" {
  description = "GCP project ID where the trigger is created"
  type        = string
}

variable "region" {
  description = "GCP region for the trigger (use 'global' for GCS, regional for Cloud Run)"
  type        = string
}

variable "trigger_name" {
  description = "Name for the Cloud Build trigger"
  type        = string
}

variable "trigger_description" {
  description = "Description for the Cloud Build trigger"
  type        = string
}

variable "cloudbuild_filename" {
  description = "Name of the cloudbuild file to use for this trigger"
  type        = string
}

variable "branch_pattern" {
  description = "Branch regex pattern to match push events (e.g., '.*' for dev, '^main$' for prod)"
  type        = string
  default     = ".*"
}

variable "service_account_email" {
  description = "Email of the service account to use for the trigger"
  type        = string
}

variable "substitutions" {
  description = "Build substitutions to pass to the Cloud Build trigger"
  type        = map(string)
  default     = {}
}

variable "included_files" {
  description = "List of file patterns that will trigger the build when changed"
  type        = list(string)
  default = [
    "src/**",
    "package.json",
    "vite.config.*",
    "yarn.lock"
  ]
}

variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
  default     = "LucaFinancial"
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
  default     = "LucaLedger"
}