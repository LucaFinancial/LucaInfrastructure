variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region where resources will be deployed"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "network_self_link" {
  description = "The self-link URL of the VPC network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet within the VPC"
  type        = string
}

variable "subnet_ip" {
  description = "The IP CIDR range of the subnet (e.g., 10.0.0.0/24)"
  type        = string
}

variable "db_version" {
  description = "The Cloud SQL database version (e.g., POSTGRES_13)"
  type        = string
}

variable "db_instance_name" {
  description = "The name to assign to the Cloud SQL instance"
  type        = string
}

variable "db_name" {
  description = "The name of the initial database to create"
  type        = string
}

variable "authorized_networks" {
  description = "List of external networks authorized to connect to the database"
  type = list(object({
    name  = string
    value = string
  }))
}

variable "db_admin_username" {
  description = "The admin username for the Cloud SQL instance"
  type        = string
}

variable "db_admin_password" {
  description = "The password for the database admin user"
  type        = string
  sensitive   = true
}

variable "db_user_username" {
  description = "The username for the application-level database user"
  type        = string
}

variable "db_user_password" {
  description = "The password for the application-level database user"
  type        = string
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection on the Cloud SQL instance"
  type        = bool
}