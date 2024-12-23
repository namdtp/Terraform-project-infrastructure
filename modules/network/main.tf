resource "google_compute_network" "network" {
  name    = var.network_name
  project = var.project_id
}

resource "google_compute_firewall" "firewall" {
  name    = var.firewall_name
  network = google_compute_network.network.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = var.allowed_ports
  }

  source_ranges = var.source_ranges
  target_tags   = var.target_tags
}
