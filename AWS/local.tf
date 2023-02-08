locals {
  environment             = lower(terraform.workspace)
  account_id = data.aws_caller_identity.current.account_id

  public_subnets_additional_tags = {
    "kubernetes.io/role/elb" : 1
    "kubernetes.io/cluster/${local.environment}-${var.project_name}-cluster" = "shared"
  }

  private_subnets_additional_tags = {
    "kubernetes.io/role/internal-elb" : 1
    "kubernetes.io/cluster/${local.environment}-${var.project_name}-cluster" = "shared"
  }

  tags = {
    "Project"   = var.project_name
    "Environment" = local.environment
  }
}

data "aws_caller_identity" "current" {}
