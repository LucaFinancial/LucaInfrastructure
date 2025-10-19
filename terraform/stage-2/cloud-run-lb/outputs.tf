output "load_balancer_ip" {
  description = "The global IP address of the load balancer"
  value       = google_compute_global_address.default.address
}

output "ssl_certificate_name" {
  description = "The name of the managed SSL certificate"
  value       = google_compute_managed_ssl_certificate.default.name
}