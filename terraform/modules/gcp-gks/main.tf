#resource "google_service_account" "this" {
#  account_id   = format("gke-cluster-%s", var.cluster_name)
#  display_name = format("%s GKE Cluster service account", var.cluster_name)
#}

data "google_compute_zones" "available" {
  region  = var.region
}

locals {
  autoscaling_resource_limits = var.autoscaling_resource_enabled ? var.autoscaling_resource_limits : []
}

resource "random_string" "random" {
  length  = 12
  number  = false
  lower   = true
  upper   = false
  special = false
}

resource "google_container_cluster" "this" {
  name     = format("%s-%s", var.cluster_name, random_string.random.result)
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = var.control_node_number

  node_config {
    preemptible = true
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  workload_identity_config {
    identity_namespace = "${var.project_id}.svc.id.goog"
  }

  cluster_autoscaling {
    enabled = var.autoscaling_resource_enabled
    dynamic "resource_limits" {
      for_each = local.autoscaling_resource_limits
      content {
        resource_type = resource_limits.value.resource_type
        minimum = resource_limits.value.minimum
        maximum = resource_limits.value.maximum
      }
    }
  }
}

resource "google_container_node_pool" "this" {
  name       = format("%s-%s", var.cluster_name, random_string.random.result)
  location   = var.region
  cluster    = google_container_cluster.this.name
  node_count = var.worker_node_number

  autoscaling {
    min_node_count = var.worker_node_number
    max_node_count = 5
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = true
    machine_type = var.worker_node_instance_type

    #service_account = google_service_account.this.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }
}