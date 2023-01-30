#!/bin/bash

set -x
set -e

NODE_NAME="SUPER12-BLAIZE-NODE"

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

sudo snap install --classic certbot

sudo ln -s /snap/bin/certbot /usr/bin/certbot



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


#docker run -d \
#--name collator \
#-u $(id -u `whoami`):$(id -g `whoami`) \
#-p 30333:30333 \
#-p 9933:9933 \
#-p 9944:9944 \
#-v "/var/lib/astar/:/data" \
#staketechnologies/astar-collator:latest \
#astar-collator \
#--collator \
#--rpc-cors=all \
#--name ${NODE_NAME} \
#--chain astar \
#--base-path /data \
#--telemetry-url 'wss://telemetry.polkadot.io/submit/ 0' \
#--execution wasm
