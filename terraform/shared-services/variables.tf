variable "project_id" {
  description = ""
  type        = string
  default     = "luca-ledger-shared-services"
}

variable "region" {
  description = ""
  type        = string
  default     = "us-central1"
}

variable "network_name" {
  description = ""
  type        = string
  default     = "luca-ledger-shared-services-vpc-network"
}

variable "subnet_name" {
  description = ""
  type        = string
  default     = "luca-ledger-shared-services-subnet"
}

variable "subnet_ip" {
  description = ""
  type        = string
  default     = "10.9.9.0/24"
}
