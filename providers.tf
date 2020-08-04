provider "helm" {
    
   kubernetes {
    host     = "https://35.192.199.8"
    config_path = "~/.kube/config"
  
    }
  }