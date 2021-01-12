terraform {
  required_version = ">=0.12.6, <0.14"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.52.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 3.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}
