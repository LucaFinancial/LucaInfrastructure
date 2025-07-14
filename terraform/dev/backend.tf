terraform {
  backend "gcs" {
    bucket = "luca-ledger-dev-tf-state"
    prefix = "tf-state/dev"
  }
}