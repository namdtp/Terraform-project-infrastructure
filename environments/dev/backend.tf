terraform {
  backend "gcs" {
    bucket  = "terraform-state-dev"
    prefix  = "dev/terraform.tfstate"
    project = "shared-project-id"
  }
}
