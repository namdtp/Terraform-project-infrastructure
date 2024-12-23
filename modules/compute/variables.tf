variable "name" {
  description = "The name of the VM instance"
  type        = string
}

variable "machine_type" {
  description = "The machine type for the instance"
  type        = string
}

variable "zone" {
  description = "The zone for the instance"
  type        = string
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "image" {
  description = "The boot image for the instance"
  type        = string
}

variable "disk_size" {
  description = "The boot disk size in GB"
  type        = number
}

variable "subnetwork" {
  description = "The subnetwork to attach the instance to"
  type        = string
}

variable "static_ip" {
  description = "The static IP for the instance"
  type        = string
}

variable "tags" {
  description = "Tags to associate with the instance"
  type        = list(string)
}
