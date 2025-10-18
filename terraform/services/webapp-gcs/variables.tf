variable "env" {
  description = "The environment the resources are being deployed to"
  type        = string
}

variable "project_id" {
  description = "GCP project ID where the trigger is created"
  type        = string
}

variable "region" {
  description = "GCP region of the repository connection (e.g., us-central1)"
  type        = string
}

variable "service_account_name_gcs" {
  description = "Name of the GCS Cloud Build Serivce Account"
  type        = string
}

variable "branch_pattern" {
  description = "Branch regex pattern to match push events (e.g., '.*' for dev, '^main$' for prod)"
  type        = string
}

variable "bucket_name" {
  description = "Name of the GCS bucket to deploy the app to"
  type        = string
}

variable "trigger_name" {
  description = "Name of the trigger that deploys this service"
  type        = string
}

variable "service_name_gcs" {
  description = "The name of the GCS service"
  type        = string
}

variable "ssl_domains" {
  description = "A list of domains for the managed SSL certificate"
  type        = list(string)
}
