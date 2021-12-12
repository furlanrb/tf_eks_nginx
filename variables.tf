variable "region" {
  default = {
    dev  = "us-east-1"
    prod = "us-east-1"
  }
}

variable "profile" {
  default = {
    dev  = "default"
    prod = "default"
  }
}

variable "tags" {
  default = {
    Product            = "eks_cluster"
    Team               = "Time_1"
  }
}

variable "project" {
  default = "eks"
}