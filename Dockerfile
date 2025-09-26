FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential gcc-arm-linux-gnueabihf qemu-user

WORKDIR /app
COPY hello.c .

# Cross compile cho ARM (BeagleBone Black là ARMv7)
RUN arm-linux-gnueabihf-gcc hello.c -o hello-arm

CMD ["qemu-arm", "./hello-arm"]
