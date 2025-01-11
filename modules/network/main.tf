
resource "google_compute_network" "tf_vpc" {
  project                 = var.proj_id
  name                    = "${var.proj_name}-vpc"
  auto_create_subnetworks = true
}

