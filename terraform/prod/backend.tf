terraform {
  backend "gcs" {
    bucket = "luca-ledger-prod-tf-state"
    prefix = "tf-state/prod"
  }
}