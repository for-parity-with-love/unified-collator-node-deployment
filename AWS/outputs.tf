output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "eks_cluster_name" {
  value = module.eks_cluster.eks_cluster_id
}

output "environment" {
  value = local.environment
}

output "project_name" {
  value = var.project_name
}
