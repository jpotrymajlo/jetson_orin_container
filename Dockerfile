ARG BASE_IMAGE=nvcr.io/nvidia/l4t-jetpack:r36.4.0

FROM ${BASE_IMAGE}
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Warsaw
COPY init_scripts/init.sh /tmp/init.sh

RUN chmod a+rx /tmp/init.sh && /tmp/init.sh

EXPOSE 22

