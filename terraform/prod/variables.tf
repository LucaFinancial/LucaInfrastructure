variable "db_user_username" {
  description = "Database user username"
  type        = string
}

variable "db_user_password" {
  description = "Database user password"
  type        = string
  sensitive   = true
}

variable "db_admin_username" {
  description = "Database admin user name"
  type        = string
  sensitive   = true
}

variable "db_admin_password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}

variable "authorized_networks" {
  description = "Networks to add to the white list for allowed access"
  type = list(object({
    name  = string
    value = string
  }))
}