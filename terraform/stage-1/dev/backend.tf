terraform {
  backend "gcs" {
    bucket = "lucaledger-devops-dev-tf-state"
    prefix = "tf-state/dev/stage-1"
  }
}
