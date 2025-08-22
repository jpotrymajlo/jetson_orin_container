#!/bin/bash

export DOCKER_GID=$(id -g)
export DOCKER_UID=$(id -u)
export DOCKER_HOME=$HOME
export DOCKER_USER=$USER
export DISPLAY=${DISPLAY}

docker compose run -it --build --service-ports --rm dev_container



