module "cluster" {
    source = "./modules/gcp-gks"
    region = var.region
    control_node_number = 2
    worker_node_number = 3
    worker_node_instance_type = "e2-medium"
}
