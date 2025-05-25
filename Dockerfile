ARG BASE_IMAGE=nvcr.io/nvidia/l4t-base:r32.7.1

FROM ${BASE_IMAGE}
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Warsaw
COPY init_scripts/init.sh /tmp/init.sh

RUN chmod a+rx /tmp/init.sh && /tmp/init.sh
