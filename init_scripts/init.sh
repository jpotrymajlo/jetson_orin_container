#!/bin/bash

set -e -x

apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    cmake \
    sudo \
    vim \
    vim-addon-manager \
    vim-youcompleteme \
    build-essential \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*


