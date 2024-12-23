module "provider" {
  source           = "../../modules/provider"
  project_id       = "woven-amulet-445102-f3"
  region           = "asia-southeast1"
  credentials_file = "path/to/credentials.json"
}

module "network" {
  source        = "../../modules/network"
  network_name  = "dev-network"
  firewall_name = "dev-firewall"
  allowed_ports = ["80", "443", "22"]
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web", "jenkins", "monitor"]
  project_id    = "woven-amulet-445102-f3"
}

module "static_ip" {
  source      = "../../modules/static-ip"
  name        = "dev-static-ip"
  project_id  = "woven-amulet-445102-f3"
  region      = "asia-southeast1"
}

module "compute" {
  source       = "../../modules/compute"
  name         = "dev-vm"
  machine_type = "e2-medium"
  zone         = "asia-southeast1-b"
  project_id   = "woven-amulet-445102-f3"
  image        = "ubuntu-os-cloud/ubuntu-2204-lts"
  disk_size    = 50
  subnetwork   = module.network.network_name
  static_ip    = module.static_ip.static_ip_address
  tags         = ["web"]
}
