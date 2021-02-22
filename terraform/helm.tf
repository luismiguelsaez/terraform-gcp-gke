
resource "kubectl_manifest" "configconnector" {
    yaml_body = templatefile("k8s/configconnector.yml",{ sa_mail = module.cluster.cluster_sa_email })
    depends_on = [module.cluster]
}

resource "time_sleep" "wait_60_seconds" {
    create_duration = "60s"
    depends_on = [kubectl_manifest.configconnector]
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

    depends_on = [time_sleep.wait_60_seconds]
}
