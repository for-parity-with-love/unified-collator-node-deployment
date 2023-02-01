#!/bin/bash

set -x
set -e

NODE_NAME="PUPER-BLAIZE-NODE"

sudo apt-get update -y
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release wget

sudo mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y && sudo apt install docker-ce docker-ce-cli \
    containerd.io docker-compose-plugin httpie -y


docker run -d -v node-data:/data dappforce/subsocial-parachain:latest subsocial-collator \
--collator \
--name="${NODE_NAME}" \
-- \
--execution=wasm \
--telemetry-url 'wss://telemetry.polkadot.io/submit/ 0' \
--chain=kusama
