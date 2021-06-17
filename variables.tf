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
  default = "AKIAXGL7F2KICDP3UXWJ"
}

variable "secret_key" {
  default = "Yqpz/cEWrZ9xUcrWl6E507pKLn/qpvSP2tKs+tSd"
}

variable "region" {
  type = string
  default = "us-west-2"
}

variable "eks_cluster_name" {
  type = string
  default = "barebone-dev"
}
