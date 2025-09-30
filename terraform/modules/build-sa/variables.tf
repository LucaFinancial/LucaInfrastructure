variable "project" {
    description = "GCP project id where the service account will be created"
    type        = string
}

variable "environment" {
    description = "Environment name (e.g., dev, prod)"
    type        = string
    validation {
        condition     = contains(["dev", "prod"], var.environment)
        error_message = "Environment must be one of: dev or prod."
    }
}

variable "service_name" {
    description = "Name of the service this SA is for (e.g., webapp, api, worker)"
    type        = string
    validation {
        condition     = can(regex("^[a-z][a-z0-9-]*[a-z0-9]$", var.service_name))
        error_message = "Service name must start with a letter, contain only lowercase letters, numbers, and hyphens, and end with a letter or number."
    }
}

variable "description" {
    description = "Optional custom description for the service account. If not provided, a default will be generated."
    type        = string
    default     = null
}

variable "additional_labels" {
    description = "Additional labels to merge with the default organizational labels"
    type        = map(string)
    default     = {}
}

variable "additional_roles" {
    description = "Additional IAM roles to grant beyond the default build roles"
    type        = list(string)
    default     = []
}