variable "region" {
  description = "The GCP region"
  type        = string
}

variable "db_version" {
  description = "The database version (e.g., POSTGRES_13)"
  type        = string
}

variable "db_instance_name" {
  description = "The name of the database instance"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "authorized_networks" {
  description = "List of authorized networks for the Cloud SQL instance"
  type = list(object({
    name  = string
    value = string
  }))
}

variable "network_self_link" {
  description = "The self link of the network"
  type        = string
}

variable "db_admin_username" {
  description = "The username for the database"
  type        = string
}

variable "db_admin_password" {
  description = "Password for the Looker Studio database user"
  type        = string
  sensitive   = true
}

variable "db_user_username" {
  description = "The username of the cloud functions user"
  type        = string
}

variable "db_user_password" {
  description = "The password for the cloud functions user"
  type        = string
}

variable "deletion_protection" {
  description = "Boolean to indicate whether or not to enable or disable deletion protection on the instance"
  type        = bool
}