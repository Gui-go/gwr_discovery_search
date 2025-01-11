locals {
  proj_name    = "gwrdiscoverysearch"
  proj_id      = "gwrdiscoverysearch1"
  location     = "us-west4"
  zone         = "us-west4-b"
  machine_type = "e2-micro"
  gpu_enabled  = false
  datastore_prevent_destroy = false
  tag_owner    = "guilhermeviegas"
}

provider "google-beta" {
  project     = local.proj_id
  region      = local.location
}

module "network" {
  source    = "./modules/network"
  proj_name = local.proj_name
  proj_id   = local.proj_id
}

module "datalake" {
  source    = "./modules/datalake"
  proj_name = local.proj_name
  proj_id   = local.proj_id
  location  = "US" # local.location
  tag_owner = local.tag_owner
}

module "searchengine" {
  source      = "./modules/searchengine"
  proj_name   = local.proj_name
  proj_id     = local.proj_id
  location    = local.location
  zone        = local.zone
  datastore_prevent_destroy = local.datastore_prevent_destroy
}

