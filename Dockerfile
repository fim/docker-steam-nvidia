FROM ubuntu:latest
MAINTAINER Serafeim Mellos <fim@mellos.io>

ARG NVIDIA_VERSION
ENV DEBIAN_FRONTEND noninteractive

# Check if nvidia version is defined
RUN test -n "$NVIDIA_VERSION" || ( echo "Please provide nvidia driver version" && exit 1)

# Install requirements
ADD http://repo.steampowered.com/steam/archive/precise/steam_latest.deb /tmp/steam.deb
ADD http://uk.download.nvidia.com/XFree86/Linux-x86_64/${NVIDIA_VERSION}/NVIDIA-Linux-x86_64-${NVIDIA_VERSION}.run /tmp/NVIDIA.run
RUN dpkg --add-architecture i386 && apt-get update &&  apt-get install -y \
    libgl1-mesa-dri:i386 libgl1-mesa-glx:i386 libc6:i386 && apt-get \
    install -y /tmp/steam.deb && sh /tmp/NVIDIA.run -a -N --ui=none --no-kernel-module

ADD entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
