variable "proj_name" {
  description = "Project name identifier"
  type        = string
}

variable "proj_id" {
  description = "Project ID identifier"
  type        = string
}

variable "location" {
  description = "Location of the resources"
  type        = string
  default     = "us-central1"
}

variable "tag_owner" {
  description = "Owner identifier"
  type        = string
  default     = "GuilhermeViegas"
}
