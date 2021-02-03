
resource "helm_release" "prometheus" {
  name       = "prometheus"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "13.4.1"
}

resource "helm_release" "mongodb" {
  name       = "mongodb"

  repository = "ttps://charts.bitnami.com/bitnami"
  chart      = "mongodb"
  version    = "10.6.1"

  # https://github.com/bitnami/charts/tree/master/bitnami/mongodb/#parameters
  set {
    name = "architecture"
    value = "replicaset"
  }
}