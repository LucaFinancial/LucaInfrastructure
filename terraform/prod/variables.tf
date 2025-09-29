variable "env" {
  type        = string
  description = "The environment"
}

variable "project_id" {
  type        = string
  description = "The ID of the GCP project"
}

variable "region" {
  type        = string
  description = "The region where resources will be deployed"
}

variable "network_name" {
  type        = string
  description = "The name of the VPC network"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet within the VPC"
}

variable "subnet_ip" {
  type        = string
  description = "The IP CIDR range of the subnet (e.g., 10.0.0.0/24)"
}

variable "db_version" {
  type        = string
  description = "The Cloud SQL database version (e.g., POSTGRES_13)"
}

variable "db_instance_name" {
  type        = string
  description = "The name to assign to the Cloud SQL instance"
}

variable "db_name" {
  type        = string
  description = "The name of the initial database to create"
}

variable "db_admin_username" {
  type        = string
  description = "The admin username for the Cloud SQL instance"
}

variable "db_admin_password" {
  type        = string
  description = "The password for the database admin user"
  sensitive   = true
}

variable "db_user_username" {
  type        = string
  description = "The username for the application-level database user"
}

variable "db_user_password" {
  type        = string
  description = "The password for the application-level database user"
  sensitive   = true
}

variable "deletion_protection" {
  type        = bool
  description = "Whether to enable deletion protection on the Cloud SQL instance"
}

variable "authorized_networks" {
  description = "List of external networks authorized to connect to the database"
  type = list(object({
    name  = string
    value = string
  }))
}