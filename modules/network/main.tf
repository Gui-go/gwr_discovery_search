
resource "google_compute_network" "tf_vpc" {
  project                 = var.proj_id
  name                    = "${var.proj_name}-vpc"
  auto_create_subnetworks = true
}

resource "google_compute_firewall" "tf_fw_ssh" {
  project = var.proj_id
  name    = "${var.proj_name}-allow-ssh"
  network = google_compute_network.tf_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "tf_fw_http" {
  project = var.proj_id
  name    = "${var.proj_name}-http"
  network = google_compute_network.tf_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "tf_fw_https" {
  project = var.proj_id
  name    = "${var.proj_name}-https"
  network = google_compute_network.tf_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "tf_static_ip" {
  project = var.proj_id
  name         = "${var.proj_name}-static-ip"
  region       = var.location
}

resource "google_dns_managed_zone" "tf_dns_zone" {
  project = var.proj_id
  name        = "${var.proj_name}-dns-zone"
  dns_name    = "guigo.dev.br."
  description = "My DNS zone"
}

resource "google_dns_record_set" "tf_a_record" {
  project = var.proj_id
  name         = "guigo.dev.br."
  managed_zone = google_dns_managed_zone.tf_dns_zone.name
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_address.tf_static_ip.address]
}

resource "google_dns_record_set" "tf_www_a_record" {
  project      = var.proj_id
  name         = "www.guigo.dev.br."
  managed_zone = google_dns_managed_zone.tf_dns_zone.name
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_address.tf_static_ip.address]
}
