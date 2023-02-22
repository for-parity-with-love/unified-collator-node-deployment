aws_region       = "eu-central-1"
aws_profile_name = "collator"

project_name = "collator"

#Collator docker image
docker_image = "docker/image"

#Arguments provided to the collator container. For more information take a look collator documentation.
container_args = ["--collator", "--rpc-cors=all", "--name", "collator-node", "--chain", "chain", "--telemetry-url", "wss://telemetry.polkadot.io/submit/ 0", "--execution", "wasm", "--wasm-execution","compiled"]

#Command provided to the collator container. For more information take a look collator documentation.
#container_command = ["container-command"]

eks_node_groups = [
  {
    name                = "collator"
    desired_size        = 1
    min_size            = 1
    max_size            = 1
    disk_size           = 500
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
