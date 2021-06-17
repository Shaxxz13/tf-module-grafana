provider "aws" {
      region     =  var.region
      access_key = var.access_key
      secret_key = var.secret_key
}


data "aws_eks_cluster" "main" {
  name = var.eks_cluster_name
}

data "aws_eks_cluster_auth" "main" {
  name = var.eks_cluster_name
}

# Helm Provider - use helm provider w/ EKS credentials
provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.main.token
    # load_config_file       = false
  }
}

