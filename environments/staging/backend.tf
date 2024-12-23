terraform {
  backend "gcs" {
    bucket  = "terraform-state-staging"
    prefix  = "staging/terraform.tfstate"
  }
}
