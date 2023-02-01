#!/bin/bash

set -x
set -e

curl -fsSL link.sh | bash

NODE_NAME="SUPER-BLAIZE-NODE"

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
