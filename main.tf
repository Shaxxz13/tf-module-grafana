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
    file("${path.module}/values.yaml"),
<<-EOF
ingress:
  enabled: ${var.ingress_enabled}
  annotations:
    kubernetes.io/ingress.class: "${var.ingress_class}"
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    ingress.kubernetes.io/rewrite-target: "/"
    ingress.kubernetes.io/ssl-redirect: "false"
  hosts:
    - ${var.hosts}
  tls: 
    - secretName: ${var.hosts}-tls
      hosts:
      - ${var.hosts}

EOF
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
