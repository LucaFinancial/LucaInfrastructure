terraform {
  backend "gcs" {
    bucket = "luca-ledger-shared-services-tf-state"
    prefix = "tf-state/shared-services"
  }
}
