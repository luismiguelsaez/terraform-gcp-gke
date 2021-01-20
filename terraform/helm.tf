resource "kubernetes_service_account" "spark" {
  metadata {
    name = "spark"
    namespace = "default"
  }
}

resource "kubernetes_role_binding" "spark" {
  metadata {
    name      = "spark"
    namespace = "default"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "spark"
  }
}

resource "helm_release" "sparkoperator" {
  name       = "spark-operator"

  #repository = "https://googlecloudplatform.github.io/spark-on-k8s-operator"
  chart      = "spark-operator/spark-operator"
  #version    = "1.0.5"

  set {
    name  = "sparkJobNamespace"
    value = "sparkJobs"
  }

  depends_on = [ kubernetes_role_binding.spark ]
}
