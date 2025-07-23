module "core" {
  source = "../modules/core"

  project_id            = var.project_id
  region                = var.region
  
  network_name          = var.network_name
  subnet_name           = var.subnet_name
  subnet_ip             = var.subnet_ip
  
  db_version            = var.db_version
  db_instance_name      = var.db_instance_name
  db_name               = var.db_name
  
  db_admin_username     = var.db_admin_username
  db_admin_password     = var.db_admin_password
  
  db_user_username      = var.db_user_username
  db_user_password      = var.db_user_password
  
  deletion_protection   = var.deletion_protection
  authorized_networks   = var.authorized_networks
}

module "web-app-gcs" {
  source = "../modules/web-app-gcs"

  env           = var.env
  project_id    = var.project_id
  region        = var.region

  service_account_name_gcs = "cloud-build-sa-gcs"
  service_name_gcs  = "luca-ledger-prod-web-app-gcs"

  branch_pattern  = ".*"
  bucket_name     = "luca-ledger-prod-web-app"

  ssl_domains = ["lucaledger.app"]
}
