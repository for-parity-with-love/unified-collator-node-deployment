#!/bin/bash

set -x
set -e


# Setup docker
curl -fsSL https://raw.githubusercontent.com/for-parity-with-love/unified-collator-spin-up/master/AWS/scripts/setup-docker.sh | bash


# Setup collator
NODE_NAME="SUPER-NODE"

docker run -d -v node-data:/data dappforce/subsocial-parachain:latest subsocial-collator \
--collator \
--name="${NODE_NAME}" \
-- \
--execution=wasm \
--telemetry-url 'wss://telemetry.polkadot.io/submit/ 0' \
--chain=kusama
