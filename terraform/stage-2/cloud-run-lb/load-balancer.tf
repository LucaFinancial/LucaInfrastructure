# Data source to reference the existing Cloud Run service
data "google_cloud_run_v2_service" "webapp" {
  name     = var.service_name
  location = var.region
  project  = var.project_id
}

resource "google_compute_global_address" "default" {
  name = "${var.service_name}-lb-ip"
}

resource "google_compute_managed_ssl_certificate" "default" {
  name = "${var.service_name}-ssl-cert-${substr(md5(join(",", sort(var.ssl_domains))), 0, 8)}"

  managed {
    domains = var.ssl_domains
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_region_network_endpoint_group" "default" {
  name                  = "${var.service_name}-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region

  cloud_run {
    service = data.google_cloud_run_v2_service.webapp.name
  }
}

resource "google_compute_backend_service" "default" {
  name                  = "${var.service_name}-backend-service"
  load_balancing_scheme = "EXTERNAL"

  backend {
    group = google_compute_region_network_endpoint_group.default.id
  }
}

resource "google_compute_url_map" "default" {
  name            = "${var.service_name}-url-map"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_target_https_proxy" "default" {
  name             = "${var.service_name}-https-proxy"
  url_map          = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}

resource "google_compute_global_forwarding_rule" "default" {
  name                  = "${var.service_name}-https-forwarding-rule"
  ip_address            = google_compute_global_address.default.address
  port_range            = "443"
  target                = google_compute_target_https_proxy.default.id
  load_balancing_scheme = "EXTERNAL"
}
