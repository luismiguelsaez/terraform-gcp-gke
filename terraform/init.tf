module "cluster" {
    source = "./modules/gcp-gks"
    cluster_name = var.kubernetes_cluster_name
    region = data.google_client_config.provider.region
    project_id = data.google_client_config.provider.project
    worker_node_number = 3
    worker_node_instance_type = "e2-medium"
}
