resource "google_sql_database_instance" "db_instance" {
  name             = var.db_instance_name
  database_version = var.db_version
  region           = var.region

  settings {
    tier = "db-f1-micro"
    edition = "ENTERPRISE"

    ip_configuration {
      ipv4_enabled    = true
      private_network = google_compute_network.vpc_network.self_link
      enable_private_path_for_google_cloud_services = true

      dynamic "authorized_networks" {
        for_each = var.authorized_networks
        content {
          name  = authorized_networks.value.name
          value = authorized_networks.value.value
        }
      }
    }

    database_flags {
      name  = "max_connections"
      value = "200"
    }

    backup_configuration {
      enabled    = true
      start_time = "02:00"  # Time in UTC for daily backups
    }
  }

  deletion_protection = var.deletion_protection
}

resource "google_sql_database" "db_name" {
  name     = var.db_name
  instance = google_sql_database_instance.db_instance.name
}

resource "google_sql_user" "db_admin_user" {
  name     = var.db_admin_username
  instance = google_sql_database_instance.db_instance.name
  password = var.db_admin_password
}

resource "google_sql_user" "db_read_only_user" {
  name     = var.db_user_username
  instance = google_sql_database_instance.db_instance.name
  password = var.db_user_password
}