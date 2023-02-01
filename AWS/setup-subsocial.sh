#!/bin/bash

set -x
set -e

curl -fsSL link.sh | bash

NODE_NAME="SUPER-BLAIZE-NODE"


docker run -d -v node-data:/data dappforce/subsocial-parachain:latest subsocial-collator \
--collator \
--name="${NODE_NAME}" \
-- \
--execution=wasm \
--telemetry-url 'wss://telemetry.polkadot.io/submit/ 0' \
--chain=kusama
