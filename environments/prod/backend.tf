terraform {
  backend "gcs" {
    bucket  = "terraform-state-prod"
    prefix  = "prod/terraform.tfstate"
  }
}
