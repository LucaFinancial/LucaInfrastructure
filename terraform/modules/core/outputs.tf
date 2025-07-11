output "network_self_link" {
  value = google_compute_network.vpc_network.self_link
}

output "instance_connection_name" {
  value = google_sql_database_instance.db_instance.connection_name
}

output "pg_private_ip" {
  value = google_sql_database_instance.db_instance.private_ip_address
}