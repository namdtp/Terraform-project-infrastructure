# Include shared variables
variable "environment" {
  description = "Target environment (dev, staging, prod)"
  default     = "dev"
}

terraform {
  required_version = ">= 1.3.0"
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
}

# Load shared configurations
module "shared_provider" {
  source           = "./modules/provider"
  project_id       = var.project_id
  region           = var.region
  credentials_file = var.credentials_file
}

module "network" {
  source        = "./modules/network"
  network_name  = "${var.environment}-network"
  firewall_name = "${var.environment}-firewall"
  allowed_ports = var.allowed_ports
  source_ranges = var.source_ranges
  target_tags   = ["${var.environment}-web"]
  project_id    = var.project_id
}

module "static_ip" {
  source     = "./modules/static-ip"
  name       = "${var.environment}-static-ip"
  project_id = var.project_id
  region     = var.region
}

module "compute" {
  source       = "./modules/compute"
  name         = "${var.environment}-vm"
  machine_type = var.machine_type
  zone         = "${var.region}-b"
  project_id   = var.project_id
  image        = var.image
  disk_size    = var.disk_size
  subnetwork   = module.network.network_name
  static_ip    = module.static_ip.static_ip_address
  tags         = ["${var.environment}-web"]
}
