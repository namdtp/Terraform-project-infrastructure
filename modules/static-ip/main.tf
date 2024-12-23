resource "google_compute_address" "static_ip" {
  name    = var.name
  project = var.project_id
  region  = var.region
}
