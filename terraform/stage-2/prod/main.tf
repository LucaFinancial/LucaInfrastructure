module "webapp-cloud-run-lb" {
  source = "../cloud-run-lb"

  env         = local.env
  project_id  = local.project_id
  region      = local.region

  service_name = "luca-ledger-prod-webapp-run"
  ssl_domains  = ["run.lucaledger.app"]
}