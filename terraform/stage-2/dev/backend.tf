terraform {
  backend "gcs" {
    bucket = "luca-ledger-devops-dev-tf-state"
    prefix = "tf-state/dev/stage-2"
  }
}
