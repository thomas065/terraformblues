# https://www.terraform.io/language/settings/backends/gcs
terraform {
  backend "gcs" {
    bucket = "terraformblues"
    prefix = "terraform/state"
    credentials = "true-artwork-456400-g8-cc40835194a7.json"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}
