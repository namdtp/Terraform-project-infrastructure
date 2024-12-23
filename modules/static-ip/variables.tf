variable "name" {
  description = "Name of the static IP"
  type        = string
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "Region for the static IP"
  type        = string
}
