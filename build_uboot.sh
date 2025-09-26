#!/usr/bin/env bash
set -euo pipefail

# Clone U-Boot (chỉ clone 1 lần nếu chưa có)
if [ ! -d "u-boot" ]; then
    git clone https://source.denx.de/u-boot/u-boot.git
fi

cd u-boot
git fetch --all
git checkout main   # chọn bản ổn định mới

# Clean build cũ
make distclean

# Config cho BeagleBone Black (AM335x-EVM là board tương thích)
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- am335x_evm_defconfig

# Build U-Boot
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-

echo "✅ Build xong U-Boot!"
ls -lh u-boot.img MLO || true
