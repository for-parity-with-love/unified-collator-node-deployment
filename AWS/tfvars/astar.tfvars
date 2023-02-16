aws_region       = "eu-central-1"
aws_profile_name = "collator"

project_name = "collator"


docker_image = "staketechnologies/astar-collator:latest"
container_command = ["astar-collator"]

#main configuration is making here. For more information take a look collator documentation.
container_args = ["--collator", "--rpc-cors=all", "--name", "collator-node", "--chain", "astar", "--telemetry-url", "wss://telemetry.polkadot.io/submit/ 0", "--execution", "wasm", "--wasm-execution","compiled"]

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
