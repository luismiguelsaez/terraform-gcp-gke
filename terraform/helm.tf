resource "helm_release" "spark_operator" {
  name       = "spark-operator-cluster"

  repository = "https://googlecloudplatform.github.io/spark-on-k8s-operator"
  chart      = "spark-operator/spark-operator"
  version    = "v1beta2-1.2.0-3.0.0"

  set {
    name  = "sparkJobNamespace"
    value = "sparkJobs"
  }
}
