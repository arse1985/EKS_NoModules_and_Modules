variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "cidr_block" {
  type        = string
  default     = "10.10.0.0/16"
  description = "cidr block for VPC"
}

variable "tags" {
  type = map(string)
  default = {
    terraform  = true
    kubernetes = "demo_eks_cluster"
  }
  description = "tag to apply to all resources"
}

variable "eks_version" {
    type = string
    default = "1.31"
    description = "eks_version"
}

variable "cluster_name" {
    type = string
    default = "demo-eks-cluster"
    description = "eks cluster name"
}



