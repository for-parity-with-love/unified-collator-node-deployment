aws_region       = "eu-central-1"
aws_profile_name = "blaize"

project_name = "collator"

node_name         = "blaize-node"

chain_name   = "astar"
docker_image = "staketechnologies/astar-collator:latest"
container_command = "astar-collator"

eks_node_groups = [
  {
    name                = "astar"
    desired_size        = 1
    min_size            = 1
    max_size            = 1          # this value can not be scaled properly right now
    disk_size           = 500
    multi_az            = true
    arch                = "amd64"
    capacity_type       = "ON_DEMAND"
    instance_types      = ["m5.xlarge"]
    ami_release_version = ["1.24.7-20221112"]
    kubernetes_labels   = {
      "node-group-purpose" = "astar"
    }
  },
]
