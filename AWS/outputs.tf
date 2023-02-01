output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "ec2_ip_address" {
  value = module.ec2_instance.public_ip
}

output "environment" {
  value = local.environment
}

output "project_name" {
  value = var.project_name
}
