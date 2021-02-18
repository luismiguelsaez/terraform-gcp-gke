output "kubernetes_cluster_name" {
    value = module.cluster.cluster_name
}

output "kubernetes_cluster_region" {
    value = var.region
}

output "kubernetes_cluster_gke_sa_email" {
    value = module.cluster.cluster_sa_email
}

output "kubernetes_cluster_gke_sa_name" {
    value = module.cluster.cluster_sa_name
}

output "project_id" {
    value = data.google_client_config.provider.project
}