locals {
  environment             = lower(terraform.workspace)

  public_subnets_additional_tags = {
    "kubernetes.io/role/elb" : 1
    "kubernetes.io/cluster/${local.environment}-${var.project_name}-cluster" = "shared"
  }
  private_subnets_additional_tags = {
    "kubernetes.io/role/internal-elb" : 1
    "kubernetes.io/cluster/${local.environment}-${var.project_name}-cluster" = "shared"
  }

  tags = {
    "kubernetes.io/cluster/${local.environment}-${var.project_name}-cluster" = "shared"
    "kubernetes.io/cluster/${local.environment}-${var.project_name}-cluster" = "shared"
    "Project"   = "${var.project_name}"
    "Environment" = "${local.environment}"
  }

  account_id = data.aws_caller_identity.current.account_id
}
