provider "google" {
  project     = "luca-ledger-dev"
  region      = "us-central1"
}

module "network" {
  source            = "../modules/network"

  project_id        = "luca-ledger-dev"
  region            = "us-central1"

  network_name                   = "luca-ledger-dev-vpc-network"
  subnet_name                    = "luca-ledger-dev-subnet"
  subnet_ip                      = "10.1.1.0/24"
}