locals {
  proj_name    = "gwrdiscoverysearch"
  proj_id      = "gwrdiscoverysearch1"
  location     = "us-west4"
  zone         = "us-west4-b"
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
  location  = local.location
  zone      = local.zone
  tag_owner = local.tag_owner
}

module "datalake" {
  source    = "./modules/datalake"
  proj_name = local.proj_name
  proj_id   = local.proj_id
  location  = "US" # local.location
  tag_owner = local.tag_owner
}

module "compute" {
  source              = "./modules/compute"
  proj_name           = local.proj_name
  proj_id             = local.proj_id
  location            = local.location
  zone                = local.zone
  machine_type        = "n1-standard-4"
  tag_owner           = local.tag_owner
  network_name        = module.network.vpc_network_name
  static_ip_address   = module.network.static_ip_address
  gpu_enabled         = false
}

module "searchengine" {
  source      = "./modules/searchengine"
  proj_name   = local.proj_name
  proj_id     = local.proj_id
  location    = local.location
  zone        = local.zone
}

