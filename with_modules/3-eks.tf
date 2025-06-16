module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  

  cluster_name    = var.cluster_name
  cluster_version = var.eks_version

  vpc_id     = module.eks_vpc.vpc_id
  create_iam_role = true   # default is true
  attach_cluster_encryption_policy = false   # default is true

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true

  control_plane_subnet_ids = concat(module.eks_vpc.private_subnets, module.eks_vpc.public_subnets)
  create_cluster_security_group = true   # default is true
  cluster_security_group_description = "eks cluster SG"
  bootstrap_self_managed_addons = true
  enable_cluster_creator_admin_permissions = true
  dataplane_wait_duration = "40s"

  # Some defaults
  enable_security_groups_for_pods = true   # true by dafault

  # Override defaults
  create_cloudwatch_log_group = false
  create_kms_key = false
  enable_kms_key_rotation = false
  kms_key_enable_default_policy = false
  enable_irsa = false   # enable your Pods to access your aws resources
  cluster_encryption_config = {}
  enable_auto_mode_custom_tags = false

  # EKS managed Node Groups
  create_node_security_group = true
  node_security_group_enable_recommended_rules = true
  node_security_group_description = "SG used by worker nodes to communicate with Cluster API server"
  node_security_group_use_name_prefix = true

  subnet_ids = module.eks_vpc.private_subnets

  

  eks_managed_node_groups = {
    group1 = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      name = "demo-eks-node-group"
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]
      capacity_type = "SPOT"

      min_size     = 2
      max_size     = 4
      desired_size = 2
    }
  }

  fargate_profiles = {
    profile1 = {
        selectors = [
            {
                namespace = "kube-system"
            }
        ]
    }
  }


}