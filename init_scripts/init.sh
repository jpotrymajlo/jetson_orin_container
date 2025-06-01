#!/bin/bash

set -e -x

apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    cmake \
    sudo \
    vim \
    vim-addon-manager \
    build-essential \
    curl \
    wget \
    ssh \
    && rm -rf /var/lib/apt/lists/*


