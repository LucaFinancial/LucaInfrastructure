provider "google" {
  project   = var.project_id
  region    = "us-central1"
}

resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name                    = var.subnet_name
  ip_cidr_range           = var.subnet_ip
  region                  = var.region
  network                 = google_compute_network.vpc_network.name
  private_ip_google_access = true
}