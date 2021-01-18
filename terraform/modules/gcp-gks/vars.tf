variable "region" {
    type = string
    default = "europe-west1"
}

variable "service_account_id" {
    type = string
    default = "gcp-gks-default"
}

variable "service_account_name" {
    type = string
    default = "gcp-gks-default"
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