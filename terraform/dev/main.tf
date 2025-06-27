provider "google" {
  project   = "luca-ledger-dev"
  region    = "us-central1"
}

module "network" {
  source          = "../modules/network"

  project_id      = "luca-ledger-dev"
  region          = "us-central1"

  network_name    = "luca-ledger-dev-vpc-network"
  subnet_name     = "luca-ledger-dev-subnet"
  subnet_ip       = "10.1.1.0/24"
}

module "sql" {
  source                = "../modules/sql"

  region                = "us-central1"

  db_instance_name      = "luca-ledger-dev-sql"
  db_version            = "POSTGRES_16"
  db_name               = "ledger"
  deletion_protection   = true
  network_self_link     = module.network.network_self_link

  db_admin_username     = var.db_admin_username
  db_admin_password     = var.db_admin_password
  db_user_username      = var.db_user_username
  db_user_password      = var.db_user_password
  authorized_networks   = var.authorized_networks

  depends_on            = [module.network]
}

module "storage" {
  source          = "../modules/storage"

  project_id      = "luca-ledger-dev"
  bucket_name     = "luca-ledger-dev-web-app-bucket"
  region          = "us-central1"
}

module "iam" {
  source          = "../modules/iam"

  project_id      = "luca-ledger-dev"
  bucket_name     = "luca-ledger-dev-web-app-bucket"

  depends_on      = [module.storage]
}