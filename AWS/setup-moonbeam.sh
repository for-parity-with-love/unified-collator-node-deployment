#!/bin/bash

set -x
set -e

curl -fsSL link.sh | bash

NODE_NAME="SUPER-BLAIZE-NODE"

docker run --network="host" -v "/var/lib/moonbeam-data:/data" \
-u $(id -u ${USER}):$(id -g ${USER}) \
purestake/moonbeam:v0.28.1 \
--base-path=/data \
--chain moonbeam \
--name="${NODE_NAME}" \
--validator \
--execution wasm \
--wasm-execution compiled \
--trie-cache-size 0 \
--db-cache 8192 \
-- \
--telemetry-url 'wss://telemetry.polkadot.io/submit/ 0' \
--execution wasm \
--name="${NODE_NAME}"
