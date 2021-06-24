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
  timeout    = "600"
  repository = var.repository
  version    = var.chart_version
 
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

  set {
    name  = "ingress.enabled"
    value = var.ingress_enabled
  }

  set {
    name  = "ingress.hosts"
    value = var.hosts
  }

  depends_on = [
    random_string.default
  ]

}
