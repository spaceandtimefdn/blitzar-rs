#!/bin/bash

set -e

export DEBIAN_FRONTEND="noninteractive"
export TZ=Etc/UTC

apt-get update
apt-get install --no-install-recommends --no-install-suggests -y \
                software-properties-common \
                build-essential \
                zip \
                git \
                ca-certificates \
                curl \
                gnupg2 \
                ssh \
                wget \
                python3 \
                python3-pip \
                llvm-dev \
                libclang-dev \
                clang

# Upgrade to g++10
# See https://ahelpme.com/linux/ubuntu/install-and-make-gnu-gcc-10-default-in-ubuntu-20-04-focal/
apt-get install --no-install-recommends --no-install-suggests -y \
                gcc-10 g++-10 cpp-10
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100 --slave /usr/bin/g++ g++ /usr/bin/g++-10 --slave /usr/bin/gcov gcov /usr/bin/gcov-10
