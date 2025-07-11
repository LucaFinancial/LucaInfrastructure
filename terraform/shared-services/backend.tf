terraform {
  backend "gcs" {
    bucket = "lf-shared-services-tf-state"
    prefix = "tf-state/ss"
  }
}