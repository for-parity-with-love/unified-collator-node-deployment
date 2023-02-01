module "ec2_instance" {
  source = "cloudposse/ec2-instance/aws"
  version = "0.45.2"
  ssh_key_pair                = "bortnik-mac"
  instance_type               = "t2.xlarge"
  vpc_id                      = module.vpc.vpc_id
  subnet                      = element(module.subnets.public_subnet_ids, 1)
  name                        = "${local.environment}-collator"

  root_volume_size             = 100


  #change whatever you would like
  user_data                   = file("${path.module}/collators/setup-astar.sh")
#  user_data                   = file("${path.module}/collators/setup-moonbeam.sh")
#  user_data                   = file("${path.module}/collators/setup-subsocial.sh")

  assign_eip_address = true
  associate_public_ip_address = true
  security_group_rules = [
    {
      type        = "egress"
      from_port   = 30333
      to_port     = 30333
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "egress"
      from_port   = 9933
      to_port     = 9933
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "egress"
      from_port   = 9944
      to_port     = 9944
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "ingress"
      from_port   = 30333
      to_port     = 30333
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "ingress"
      from_port   = 9933
      to_port     = 9933
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "ingress"
      from_port   = 9944
      to_port     = 9944
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}
