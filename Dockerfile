FROM ubuntu:22.04

# Cài toolchain ARM + deps build U-Boot
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    wget \
    ca-certificates \
    bison \
    flex \
    python3 \
    python3-distutils \
    libssl-dev \
    libssl3 \
    libgnutls28-dev \
    device-tree-compiler \
    u-boot-tools \
    gcc-arm-linux-gnueabihf \
    crossbuild-essential-armhf \
    qemu-system-arm \
    gdb-multiarch \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build
