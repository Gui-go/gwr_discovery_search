output "vpc_network_name" {
  value = google_compute_network.tf_vpc.name
}

output "static_ip_address" {
  value = google_compute_address.tf_static_ip.address
}

