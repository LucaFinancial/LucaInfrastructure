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

resource "google_compute_global_address" "private_ip_range" {
  name          = "${var.network_name}-private-ip-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc_network.self_link
}

resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.vpc_network.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_range.name]
}

resource "google_compute_network_peering_routes_config" "export_routes" {
  project              = var.project_id
  network              = google_compute_network.vpc_network.name
  peering              = "servicenetworking-googleapis-com"
  export_custom_routes = true
  import_custom_routes = false

  depends_on = [google_service_networking_connection.default]
}