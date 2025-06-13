output "instance_connection_name" {
  value = google_sql_database_instance.db_instance.connection_name
}

output "pg_private_ip" {
  value = google_sql_database_instance.db_instance.private_ip_address
}