variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_ip" {
  description = "The IP range of the subnet"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}