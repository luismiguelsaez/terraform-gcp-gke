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
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "1.13.3"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
  }
}

#provider "google" {
#  region = var.region
#  project = var.project
#}

data "google_client_config" "provider" {}

provider "kubernetes" {
  host = module.cluster.cluster_endpoint

  token = data.google_client_config.provider.access_token

  client_certificate     = module.cluster.cluster_client_certificate
  client_key             = module.cluster.cluster_client_key
  cluster_ca_certificate = base64decode( module.cluster.cluster_ca_certificate )

  load_config_file = false
}

provider "kubectl" {
  host = module.cluster.cluster_endpoint

  token = data.google_client_config.provider.access_token

  client_certificate     = module.cluster.cluster_client_certificate
  client_key             = module.cluster.cluster_client_key
  cluster_ca_certificate = base64decode( module.cluster.cluster_ca_certificate )

  load_config_file = false
}

provider "helm" {
  kubernetes {
    host                   = module.cluster.cluster_endpoint
    token                  = data.google_client_config.provider.access_token
    client_certificate     = module.cluster.cluster_client_certificate
    client_key             = module.cluster.cluster_client_key
    cluster_ca_certificate = base64decode( module.cluster.cluster_ca_certificate )
  }
}
