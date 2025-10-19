variable "env" {
  description = "The environment the resources are being deployed to"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "service_name" {
  description = "The name of the Cloud Run service"
  type        = string
}

variable "ssl_domains" {
  description = "A list of domains for the managed SSL certificate"
  type        = list(string)
}