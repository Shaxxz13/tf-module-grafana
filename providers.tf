terraform {
  required_providers {
    helm = "~> 0.10.5"
  }
}
provider "helm" {
    install_tiller  = true
    namespace       = "kube-system"
    service_account = "tiller"
    tiller_image    = "gcr.io/kubernetes-helm/tiller:v2.16.8"
    home            = "/home/idadmin/.helm"
    
   kubernetes {
    host     = "https://35.239.223.187"
    # username = "admin"
    # password = "mykeusermykeusermyke"
    config_path = "~/.kube/config"
  
    }
  }