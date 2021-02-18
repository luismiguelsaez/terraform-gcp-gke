output "cluster_name" {
    value = google_container_cluster.this.name
}

output "cluster_endpoint" {
    value = google_container_cluster.this.endpoint
}

output "cluster_client_certificate" {
    value = google_container_cluster.this.master_auth.0.client_certificate
}

output "cluster_client_key" {
    value = google_container_cluster.this.master_auth.0.client_key
}

output "cluster_ca_certificate" {
    value = google_container_cluster.this.master_auth.0.cluster_ca_certificate
}

output "cluster_sa_name" {
    value = google_service_account.this.name
}

output "cluster_sa_email" {
    value = google_service_account.this.email
}
