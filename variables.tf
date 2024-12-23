# General variables

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "credentials_file" {
  description = "Path to the GCP service account credentials JSON file"
  type        = string
}

# Network variables
variable "allowed_ports" {
  description = "List of allowed ports for firewall rules"
  type        = list(string)
}

variable "source_ranges" {
  description = "List of source IP ranges allowed by the firewall"
  type        = list(string)
}

# Compute instance variables
variable "machine_type" {
  description = "The machine type for the compute instances"
  type        = string
}

variable "disk_size" {
  description = "The boot disk size in GB"
  type        = number
}

variable "image" {
  description = "The image to use for the compute instances"
  type        = string
}
