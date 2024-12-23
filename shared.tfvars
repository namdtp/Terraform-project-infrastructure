# Shared variables across all environments
project_id     = "woven-amulet-445102-f3"
region         = "asia-southeast1"
credentials_file = "./credentials.json"

# Default VM configurations
machine_type   = "e2-medium"
image          = "ubuntu-os-cloud/ubuntu-2204-lts"
disk_size      = 50

# Network configurations
allowed_ports  = ["80", "443", "22"]
source_ranges  = ["0.0.0.0/0"]
