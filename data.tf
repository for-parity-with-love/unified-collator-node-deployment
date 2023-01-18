#uncomment it just in case if you need to add additional admin to aws-auth config
#data "aws_iam_group" "eks_admin" {
#  group_name = "cluster_access"
#}

data "aws_kms_alias" "kms_alias_eks_cluster" {
  name = "alias/${module.eks_cluster.eks_cluster_id}"
}

data "aws_caller_identity" "current" {}
