resource "google_service_account" "this" {
  account_id   = format("gke-cluster-%s", var.cluster_name)
  display_name = format("%s GKE Cluster service account", var.cluster_name)
}

data "google_compute_zones" "available" {
  region  = var.region
}

resource "google_container_cluster" "this" {
  name     = var.cluster_name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = var.control_node_number

  cluster_autoscaling {
    enabled = var.autoscaling_resource_enabled
    dynamic "resource_limits" {
      for_each = var.autoscaling_resource_limits
      content {
        resource_type = resource_limits.value.resource_type
        minimum = resource_limits.value.minimum
        maximum = resource_limits.value.maximum
      }
    }
  }
}

resource "google_container_node_pool" "this" {
  name       = var.cluster_name
  location   = var.region
  cluster    = google_container_cluster.this.name
  node_count = var.worker_node_number

  node_config {
    preemptible  = true
    machine_type = var.worker_node_instance_type

    service_account = google_service_account.this.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}