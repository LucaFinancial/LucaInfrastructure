variable "project" {
    description = "GCP project id where the service account will be created"
    type        = string
}

variable "account_id" {
    description = "Service account id (unique within the project), e.g. 'build-sa'"
    type        = string
}

variable "display_name" {
    description = "Human readable display name for the service account. Defaults to account_id when empty."
    type        = string
    default     = ""
}

variable "description" {
    description = "Optional description for the service account"
    type        = string
    default     = "Service account created by terraform module"
}

variable "disabled" {
    description = "Whether the service account should be created disabled"
    type        = bool
    default     = false
}

variable "labels" {
    description = "Optional labels to attach to the service account"
    type        = map(string)
    default     = {}
}