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
  default = "us-west-2"
}

variable "eks_cluster_name" {
  type = string
  default = "barebone-test-test"
}

variable "repository" {
  type = string
  default = ""
}

variable "chart_version" {
  type = string
  default = ""
}

variable "ingress_class" {
  type = string
  default = ""
}

variable "ingress_enabled" {
  type = string
  default = ""
}

variable "pvc" {
  type = string
  default = false
}

variable "hosts" {
  type = string
  default = false
}

variable "branch" {
  type = string
  default = "develop"
}

variable "username" {
  type = string
  default = ""
}

variable "password" {
  type = string
  default = "develop"
}




