aws_region       = "eu-central-1"
aws_profile_name = "collator"

project_name = "collator"


docker_image = "acala/karura-node:latest"

#main configuration is making here. For more information take a look collator documentation.
container_args = ["--collator", "--name", "collator-node", "--chain", "karura", "--execution", "wasm"]


eks_node_groups = [
  {
    name                = "karura"
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
