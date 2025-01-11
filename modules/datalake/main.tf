
resource "google_storage_bucket" "tf_references_bucket" {
  name          = "${var.proj_name}-references-bucket"
  project       = var.proj_id
  location      = var.location
  storage_class = "NEARLINE" # STANDARD NEARLINE COLDLINE ARCHIVE
  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "ARCHIVE"
    }
    condition {
      age = 180 # Move to ARCHIVE after 180 days
    }
  }
  labels = {
    environment = "varproj_name"
    project     = var.proj_id
    owner       = var.tag_owner
  }
}
