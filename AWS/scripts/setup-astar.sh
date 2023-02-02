#!/bin/bash

set -x
set -e


# Setup docker
curl -fsSL https://raw.githubusercontent.com/for-parity-with-love/unified-collator-spin-up/master/AWS/scripts/setup-docker.sh | bash


# Setup collator
NODE_NAME="SUPER-NODE"

docker run -d \
--name collator \
-u $(id -u `whoami`):$(id -g `whoami`) \
-p 30333:30333 \
-p 9933:9933 \
-p 9944:9944 \
-v "/var/lib/astar/:/data" \
staketechnologies/astar-collator:latest \
astar-collator \
--collator \
--rpc-cors=all \
--name ${NODE_NAME} \
--chain astar \
--base-path /data \
--telemetry-url 'wss://telemetry.polkadot.io/submit/ 0' \
--execution wasm
