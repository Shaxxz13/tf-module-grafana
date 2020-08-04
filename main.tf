resource "helm_release" "grafana" {
  name  = "grafana-nx"
  chart = "grafana"
  atomic = true 
  create_namespace = true
  namespace = var.namespace
  repository = data.helm_repository.grafana.url


  values = [
    "${file("values.yaml")}"
  ]
}
