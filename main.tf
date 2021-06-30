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
  timeout    = "120"
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
,
<<-EOF
extraEmptyDirMounts: 
  - name: git-dashboards
    mountPath: /var/git/

EOF
,
    <<-EOF
    extraContainers: |
      - name: git-sync
        image: k8s.gcr.io/git-sync:v3.1.6
        volumeMounts:
        - name: git-dashboards
          mountPath: /var/git/
        # - name: git-secret
        #   mountPath: /etc/git-secret
        #   readOnly: true
        securityContext:
          runAsUser: 65533 #perm
        args:
        - --repo=https://github.com/nxterraform/grafana_dashboards.git
        - --root=/var/git/
        - --dest=git-dashboards
        - --wait=30
        - --branch=${var.branch}
        - --username=${var.username}
        - --password=${var.password}
EOF
,

<<-EOF
dashboardProviders: 
 dashboardproviders.yaml:
   apiVersion: 1
   providers:
   - name: 'default'
     orgId: 1
     folder: 'core'
     type: file
     disableDeletion: false
     editable: true
     options:
       path: /var/git/git-dashboards/core
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

  set {
    name  = "persistence.enabled"
    value = var.pvc
  }


  depends_on = [
    random_string.default
  ]

}
