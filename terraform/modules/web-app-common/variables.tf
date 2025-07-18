variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "The name of the Cloud Storage bucket for the static site"
  type        = string
}

variable "service_name" {
  description = ""
  type        = string
}

variable "name" {
  description = "A unique name prefix for all resources"
  type        = string
}

variable "bucket_name" {
  description = "The name of the GCS bucket to serve content from"
  type        = string
}

variable "ssl_domains" {
  description = "A list of domains for the managed SSL certificate"
  type        = list(string)
}