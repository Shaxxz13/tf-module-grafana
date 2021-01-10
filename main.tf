resource "helm_release" "grafana" {
  name  = "grafana-nx"
  chart = "grafana"
  atomic = true 
  create_namespace = true
  namespace = var.namespace
  # repository = data.helm_repository.grafana.url
  repository = "https://charts.helm.sh/stable"

  values = [
    file("${path.module}/values.yaml")
  ]
}
