resource "google_service_account" "this" {
  account_id   = var.service_account_id
  display_name = var.service_account_name
}

resource "google_container_cluster" "this" {
  name     = "my-gke-cluster"
  location = var.region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = var.control_node_number
}

resource "google_container_node_pool" "this" {
  name       = "my-node-pool"
  location   = var.region
  cluster    = google_container_cluster.this.name
  node_count = var.worker_node_number

  node_config {
    preemptible  = true
    machine_type = var.worker_node_instance_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.this.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}