aws_region       = "eu-central-1"
aws_profile_name = "blaize"

project_name = "collator"

node_name         = "blaize-node"

chain_name   = "kusama"
docker_image = "dappforce/subsocial-parachain:latest"
container_command = "subsocial-collator"

eks_node_groups = [
  {
    name                = "subsocial"
    desired_size        = 1
    min_size            = 1
    max_size            = 1
    disk_size           = 300
    multi_az            = true
    arch                = "amd64"
    capacity_type       = "ON_DEMAND"
    instance_types      = ["m5.xlarge"]
    ami_release_version = ["1.24.7-20221112"]
    kubernetes_labels   = {
      "node-group-purpose" = "collator"
    }
  },
]
