locals {
  environment             = lower(terraform.workspace)
  account_id = data.aws_caller_identity.current.account_id
}

data "aws_caller_identity" "current" {}
