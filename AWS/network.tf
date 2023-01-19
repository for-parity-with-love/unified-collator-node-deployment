locals {
  first_octet = random_integer.octet1.result
  second_octet = random_integer.octet2.result
  final_first_cidr = join(".", [local.first_octet, local.second_octet, "0", "0/16"])
  incremented_second_octet =  format(random_integer.octet2.result + "1")
  final_second_cidr =  replace(local.final_first_cidr, "${local.second_octet}.0.0/16", "${local.incremented_second_octet}.0.0/16")

}

data "aws_availability_zones" "available" {}

resource "random_integer" "octet1" {
  min     = 1
  max     = 254
}

resource "random_integer" "octet2" {
  min     = 0
  max     = 254
}

module "vpc" {
  source = "cloudposse/vpc/aws"
  version = "1.1.1"

  ipv4_primary_cidr_block = local.final_first_cidr
  assign_generated_ipv6_cidr_block = true

  attributes = ["vpc"]
  context = module.label.context
  tags    = local.tags
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_ipv4_cidr" {
  vpc_id     = module.vpc.vpc_id
  cidr_block = local.final_second_cidr
}

module "subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "2.0.4"

  max_nats = "1"
  availability_zones = data.aws_availability_zones.available.names
  vpc_id             = module.vpc.vpc_id
  igw_id             = [module.vpc.igw_id]
  ipv6_enabled = "true"
  ipv4_enabled = "true"
  ipv6_cidr_block          = [module.vpc.vpc_ipv6_cidr_block]
  ipv4_cidr_block          = [module.vpc.vpc_cidr_block]

  context = module.label.context
  tags    = local.tags

  public_subnets_additional_tags  = local.public_subnets_additional_tags
  private_subnets_additional_tags = local.private_subnets_additional_tags
}
