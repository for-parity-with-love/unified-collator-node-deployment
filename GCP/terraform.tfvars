region             = "us-central1"
project_id         = "replace value"

project_name = "collator"

#Collator docker image
docker_image = "docker/image"

#Arguments provided to the collator container. For more information take a look collator documentation.
container_args = ["--collator", "--rpc-cors=all", "--name", "collator-node", "--chain", "chain", "--telemetry-url", "wss://telemetry.polkadot.io/submit/ 0", "--execution", "wasm", "--wasm-execution","compiled"]

#Command provided to the collator container. For more information take a look collator documentation.
#container_command = ["container-command"]
