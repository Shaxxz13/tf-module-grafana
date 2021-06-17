// Random string generator for Grafana password
resource "random_string" "default" {
  length      = 16
  special     = false
  min_upper   = 3
  min_numeric = 4
}


resource "helm_release" "grafana" {
  name       = "grafana"
  chart      = "grafana"
  atomic     = true
  create_namespace = true
  namespace  = var.namespace
  repository = "https://grafana.github.io/helm-charts"
  timeout    = "600"
  version    = "6.13.0"
 
  values = [
    file("${path.module}/values.yaml")
  ]

  set {
    name  = "adminPassword"
    value = random_string.default.result
  }

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name  = "persistence.size"
    value = var.diskSize
  }

  depends_on = [
    random_string.default
  ]

}
