variable "region" {
    type = string
    default = "europe-west1"
}

variable "project_id" {
    type = string
}

variable "cluster_name" {
    type = string
    default = "default"
}

variable "worker_node_number" {
    type = number
    default = 1
}

variable "worker_node_instance_type" {
    type = string
    default = "e2-medium"
}
