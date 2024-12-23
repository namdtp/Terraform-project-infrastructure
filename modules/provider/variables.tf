variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "credentials_file" {
  description = "Path to the GCP service account key file"
  type        = string
}
