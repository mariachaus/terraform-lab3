terraform {
  required_version = ">= 1.14.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
    }
  }
}

provider "google" {
  project = "eternal-sylph-487816-f1"
  region  = "europe-west1"
  zone    = "europe-west1-b"
}