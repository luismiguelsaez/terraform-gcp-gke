resource "helm_release" "spark_operator" {
  name       = "spark-operator-cluster"

  repository = "https://googlecloudplatform.github.io/spark-on-k8s-operator"
  chart      = "spark-operator/spark-operator"

  set {
    name  = "sparkJobNamespace"
    value = "SparkCluster"
  }
}
