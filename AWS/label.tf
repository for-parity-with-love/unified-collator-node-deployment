module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  environment   = "${local.environment}"
  name      = var.project_name
}

module "vpc_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"


  environment   = "${local.environment}"
  name      = var.project_name
}
