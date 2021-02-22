resource "google_service_account" "this" {
  account_id   = format("gke-cluster-%s", var.cluster_name)
  display_name = format("%s GKE Cluster service account", var.cluster_name)
}

data "google_iam_policy" "this" {
  binding {
    role = "roles/storage.admin"
    members = [
      "serviceAccount:${google_service_account.this.email}",
    ]
  }
  binding {
    role = "roles/pubsub.admin"
    members = [
      "serviceAccount:${google_service_account.this.email}",
    ]
  }
  binding {
    role = "roles/owner"
    members = [
      "serviceAccount:${google_service_account.this.email}",
    ]
  }
}

resource "google_project_iam_policy" "this" {
  project     = var.project_id
  policy_data = data.google_iam_policy.this
}

# https://cloud.google.com/config-connector/docs/how-to/install-upgrade-uninstall
#resource "google_project_iam_member" "this" {
#  project = var.project_id
#  role    = "roles/owner"
#  member  = "serviceAccount:${google_service_account.this.email}"
#}

resource "google_service_account_iam_member" "this" {
  service_account_id = google_service_account.this.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[cnrm-system/cnrm-controller-manager]"
}

resource "google_container_cluster" "this" {
  # Enabled beta provider, as standard one doesn't allow enabling config connector
  provider = google-beta

  name     = var.cluster_name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  workload_identity_config {
    identity_namespace = "${var.project_id}.svc.id.goog"
  }

  addons_config {
    config_connector_config {
      enabled = true
    }
  }
}

resource "google_container_node_pool" "this" {
  name       = var.cluster_name
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
    preemptible  = false
    machine_type = var.worker_node_instance_type

    service_account = google_service_account.this.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}