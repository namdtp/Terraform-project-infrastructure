variable "network_name" {
  description = "Name of the network"
  type        = string
}

variable "firewall_name" {
  description = "Name of the firewall rule"
  type        = string
}

variable "allowed_ports" {
  description = "List of allowed ports for the firewall"
  type        = list(string)
}

variable "source_ranges" {
  description = "Source ranges allowed by the firewall"
  type        = list(string)
}

variable "target_tags" {
  description = "Target tags for the firewall rule"
  type        = list(string)
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}
