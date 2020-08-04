#!/bin/bash

export HOME_DIR=$(git rev-parse --show-toplevel)
export FABRIC_CFG_PATH="${HOME_DIR}/config"

docker kill logspout || true
./network.sh down

# remove any stopped containers
docker rm $(docker ps -aq)

