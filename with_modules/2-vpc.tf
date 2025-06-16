data "aws_availability_zones" "available" {
  state = "available"
}

module "eks_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.cidr_block

  azs             = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  private_subnets = [cidrsubnet(var.cidr_block, 8, 110), cidrsubnet(var.cidr_block, 8, 120)]
  public_subnets  = [cidrsubnet(var.cidr_block, 8, 10), cidrsubnet(var.cidr_block, 8, 20)]
  create_igw = true   # by default is true
  enable_dns_hostnames = true   # by default is true, daca nu e e true Worker Nodes s-ar putea sa aiba probleme sa se ataseze la cluster

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false   # din rationamente financiare folosim 1 singur Nat GW
  create_private_nat_gateway_route = true   # by default is true

  tags = var.tags
}