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

variable "service_name" {
  description = "The name of the Cloud Run service"
  type        = string
}

variable "service_account_name" {
  description = "Name of the Cloud Run Cloud Build Service Account"
  type        = string
}

variable "branch_pattern" {
  description = "Branch regex pattern to match push events (e.g., '.*' for dev, '^main$' for prod)"
  type        = string
}

variable "trigger_name" {
  description = "Name of the trigger that deploys this service"
  type        = string
}

variable "ssl_domains" {
  description = "A list of domains for the managed SSL certificate"
  type        = list(string)
}

variable "repository_id" {
  description = "ID for the Artifact Registry repository"
  type        = string
}

variable "repository_description" {
  description = "Description for the Artifact Registry repository"
  type        = string
  default     = "Container registry for Luca Ledger web app"
}