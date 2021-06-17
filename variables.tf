variable "namespace" {
  type = string
  default = "monitoring"
}

variable "diskSize" {
  type = string
  default = "3Gi"
}

variable "access_key" {
  type = string
  default = ""
}

variable "secret_key" {
  default = ""
}

variable "region" {
  type = string
  default = "us-east-2"
}

variable "eks_cluster_name" {
  type = string
  default = "barebone-dev"
}
