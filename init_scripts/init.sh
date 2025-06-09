#!/bin/bash

set -e -x

apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    sudo \
    vim \
    vim-addon-manager \
    build-essential \
    curl \
    wget \
    ssh \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

wget https://github.com/Kitware/CMake/releases/download/v4.0.2/cmake-4.0.2-linux-aarch64.sh \
    -q -O /tmp/cmake-install.sh && \
    chmod u+x /tmp/cmake-install.sh && \
    mkdir /opt/cmake-4.0.2 && \
    /tmp/cmake-install.sh --skip-license --prefix=/opt/cmake-4.0.2 && \
    rm /tmp/cmake-install.sh && \
    ln -s /opt/cmake-4.0.2/bin/* /usr/local/bin

pip install conan
