terraform {
  backend "gcs" {
    bucket = "lucaledger-devops-prod-tf-state"
    prefix = "tf-state/prod/stage-1"
  }
}
