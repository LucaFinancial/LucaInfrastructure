terraform {
  backend "gcs" {
    bucket = "luca-ledger-devops-prod-tf-state"
    prefix = "tf-state/prod"
  }
}
