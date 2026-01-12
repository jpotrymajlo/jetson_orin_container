#!/bin/bash

export DOCKER_GID=$(id -g)
export DOCKER_UID=$(id -u)
export DOCKER_HOME=$HOME
export DOCKER_USER=$USER
export DISPLAY=${DISPLAY}

if command -v nvidia-smi &> /dev/null; then
    docker compose run -it --build --service-ports --rm gpu_dev_container
else
    docker compose run -it --build --service-ports --rm dev_container
fi




