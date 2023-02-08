#uncomment it just in case if you need to add additional admin to aws-auth config
#data "aws_iam_group" "eks_admin" {
#  group_name = "cluster_access"
#}

locals {
  cluster_version                              = "1.24"
  aws_vpc_cni_version                          = "v1.12.0"
  aws_core_dns_version                         = "v1.8.7"
  eks_node_groups_defaults                     = {
    kubernetes_version                         = local.cluster_version
  }

  eks_node_groups = { for group in var.eks_node_groups :
    format("%s-%s-%s-%s-%s",
      group.name,
      group.arch,
      replace(lower(group.capacity_type), "_", ""),
      group.kubernetes_version,
      md5(join(",", group.instance_types))
    ) => group
  }

#uncomment it just in case if you need to add additional admin to aws-auth config
#  eks_admins = [
#    for user in data.aws_iam_group.eks_admin.users :
#    {
#      userarn                                  = user.arn
#      username                                 = user.user_name
#      groups                                   = ["system:masters"]
#    }
#  ]
}

module "eks_cluster" {
  source                                       = "cloudposse/eks-cluster/aws"
  version                                      = "2.6.0"


  region                                       = var.aws_region
  vpc_id                                       = module.vpc.vpc_id
  subnet_ids                                   = concat(module.subnets.private_subnet_ids)

  kubernetes_version                           = local.cluster_version
  oidc_provider_enabled                        = true

  #uncomment it just in case if you need to add additional admin to aws-auth config
  #map_additional_iam_users                     = local.eks_admins
  kubernetes_network_ipv6_enabled              = false

  kubernetes_config_map_ignore_role_changes    = true
  apply_config_map_aws_auth                    = true
  kube_data_auth_enabled                       = true

  enabled_cluster_log_types                    = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_log_retention_period                 = 30

  addons = [
    {
      addon_name               = "vpc-cni"
      addon_version            = format("%s-eksbuild.1", local.aws_vpc_cni_version)
      resolve_conflicts        = "OVERWRITE"
      service_account_role_arn = null
    },
#    {
#      addon_name               = "coredns"
#      addon_version            = format("%s-eksbuild.3", local.aws_core_dns_version)
#      resolve_conflicts        = "OVERWRITE"
#      service_account_role_arn = null
#    }
  ]

  context = module.label.context
}

module "eks_node_groups" {
  source                                       = "cloudposse/eks-node-group/aws"
  version                                      = "2.6.1"

  for_each                                     = local.eks_node_groups
  cluster_name                                 = module.eks_cluster.eks_cluster_id
  subnet_ids                                   = each.value.multi_az ? module.subnets.private_subnet_ids : [module.subnets.private_subnet_ids[0]]
  detailed_monitoring_enabled                  = true
  instance_types                               = each.value.instance_types
  min_size                                     = each.value.min_size
  desired_size                                 = each.value.desired_size
  max_size                                     = each.value.max_size
  capacity_type                                = each.value.capacity_type
  kubernetes_labels                            = each.value.kubernetes_labels
  ami_release_version                          = each.value.ami_release_version
  node_role_policy_arns                        = ["arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy"]

  block_device_mappings                        = [
    {
      device_name                              = "/dev/xvda"
      volume_size                              = each.value.disk_size
      volume_type                              = "gp3"
      encrypted                                = true
      delete_on_termination                    = true
    }
  ]

  create_before_destroy                        = true
  cluster_autoscaler_enabled                   = true
  module_depends_on                            = [module.eks_cluster.kubernetes_config_map_id]

  attributes                                   = [
     join("-", [local.environment, var.project_name, each.value.name])
  ]

  depends_on                                   = [module.eks_cluster]
}

resource "aws_autoscaling_group_tag" "eks_node_groups" {
  for_each                                     = local.eks_node_groups

  autoscaling_group_name                       = module.eks_node_groups[each.key].eks_node_group_resources[0][0].autoscaling_groups[0].name
  tag {
    key                                        = format("k8s.io/cluster-autoscaler/node-template/label/%v", keys(each.value.kubernetes_labels)[0])
    value                                      = values(each.value.kubernetes_labels)[0]
    propagate_at_launch                        = true
  }
}

resource "time_sleep" "eks_node_groups_wait" {
  for_each                                     = local.eks_node_groups

  create_duration                              = "60s"
  triggers                                     = {
    eks_node_group_id                          = module.eks_node_groups[each.key].eks_node_group_id
    eks_node_group_arn                         = module.eks_node_groups[each.key].eks_node_group_arn
  }
}

resource "aws_eks_addon" "coredns" {
  cluster_name      = module.eks_cluster.eks_cluster_id
  addon_name        = "coredns"
  addon_version     = format("%s-eksbuild.3", local.aws_core_dns_version)
  resolve_conflicts = "OVERWRITE"

  depends_on = [time_sleep.eks_node_groups_wait]
}