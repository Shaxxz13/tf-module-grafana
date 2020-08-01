resource "helm_release" "grafana" {
  name  = "grafana-nx"
  chart = "grafana"
  namespace = var.namespace
  repository = data.helm_repository.grafana.url
#   create_namespace = true
#   cleanup_on_fail = true

  values = [
    "${file("/home/idadmin/ME/planNapply/NX-GCP | Modules/Modules/grafana/values.yaml")}"
  ]
}
