
resource "kubectl_manifest" "configconnector" {
    yaml_body = templatefile("k8s/configconnector.yml",{ sa_mail = module.cluster.cluster_sa_email })
}

resource "helm_release" "this" {
    name       = "configconnector"
    chart      = "./charts/configconnector"

    set {
        name  = "gcloud.serviceaccount.email"
        value = module.cluster.cluster_sa_email
    }

    set {
        name  = "gcloud.project" 
        value = data.google_client_config.provider.project
    }

    depends_on = [kubectl_manifest.configconnector]
}
