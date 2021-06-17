terraform {
  backend "s3" {
    bucket = "barebone-dev-tfstate"
    key    = "monitoring/tfstates/"
    region = "us-east-2"
  }
}