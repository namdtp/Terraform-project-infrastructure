terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.68.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
}

resource "google_project_service" "required_services" {
  for_each = toset(["compute.googleapis.com", "storage.googleapis.com"])
  project  = var.project_id
  service  = each.key
}

resource "google_project_service" "enable_apis" {
  for_each = toset([
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "storage.googleapis.com"
  ])

  project = var.project_id
  service = each.key
    disable_on_destroy         = true
  disable_dependent_services = true
}
