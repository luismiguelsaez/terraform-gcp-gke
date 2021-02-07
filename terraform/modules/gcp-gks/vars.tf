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

variable "control_node_number" {
    type = number
    default = 1
}

variable "worker_node_number" {
    type = number
    default = 1
}

variable "worker_node_instance_type" {
    type = string
    default = "e2-medium"
}

variable "autoscaling_resource_enabled" {
    type = bool
    default = false
}

variable "autoscaling_resource_limits" {
    type = list
    default = [
        {
            resource_type = "cpu"
            minimum       = 4
            maximum       = 16
        },
        {
            resource_type = "memory"
            minimum       = 8
            maximum       = 32
        }
    ]
}