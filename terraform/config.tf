terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.52.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.0.2"
    }
  }
}

provider "google" {
  region = var.region
  project = var.project
}

provider "helm" {
  kubernetes {
    host = module.cluster.cluster_endpoint
    client_certificate     = module.cluster.cluster_client_certificate
    client_key             = module.cluster.cluster_client_key
    cluster_ca_certificate = module.cluster.cluster_ca_certificate
  }
}
