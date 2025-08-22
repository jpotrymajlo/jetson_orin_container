ARG BASE_IMAGE=nvcr.io/nvidia/l4t-jetpack:r36.4.0

FROM ${BASE_IMAGE}
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Warsaw

ARG DOCKER_USER=user
ARG DOCKER_HOME=/home/user
ARG DOCKER_UID=1234
ARG DOCKER_GID=1234

RUN groupadd --gid "${DOCKER_GID}" ${DOCKER_USER}  \
    && useradd --uid "${DOCKER_UID}" --gid "${DOCKER_GID}" --groups sudo -m -d "${DOCKER_HOME}" "${DOCKER_USER}" \
    && usermod --shell /bin/bash ${DOCKER_USER} \
    && echo "${DOCKER_USER}:nvidia" | chpasswd \
    && echo "${DOCKER_USER}     ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY init_scripts/init.sh /tmp/init.sh

RUN chmod a+rx /tmp/init.sh && /tmp/init.sh

USER ${DOCKER_USER}
WORKDIR ${DOCKER_HOME}

