module "ec2_instance" {
  source = "cloudposse/ec2-instance/aws"
  version = "0.45.2"
  ssh_key_pair                = "bortnik-mac"
  instance_type               = "t2.xlarge"
  vpc_id                      = module.vpc.vpc_id
  subnet                      = element(module.subnets.public_subnet_ids, 1)
  name                        = "${local.environment}-collator"

  root_volume_size             = 100


  user_data                   = file("${path.module}/setup-astar.sh")
#  user_data                   = file("${path.module}/setup-moonbeam.sh")
#  user_data                   = file("${path.module}/setup-subsocial.sh")

  assign_eip_address = true
  associate_public_ip_address = true
  security_group_rules = [
    {
      type        = "egress"
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "ingress"
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}
