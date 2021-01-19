module "cluster" {
    source = "./modules/gcp-gks"
    cluster_name = var.kubernetes_cluster_name
    region = var.region
    control_node_number = 2
    worker_node_number = 3
    worker_node_instance_type = "e2-medium"
    autoscaling_resource_enabled = true
}
