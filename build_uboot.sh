#!/usr/bin/env bash
set -euo pipefail

# In CI/CD, we must always clone to ensure a clean slate.
# Remove the old directory to avoid "already exists" errors.
if [ -d "u-boot" ]; then
    echo "Directory u-boot exists. Removing it for a fresh clone."
    rm -rf "u-boot"
fi

echo "Cloning U-Boot repository..."
git clone https://source.denx.de/u-boot/u-boot.git

echo "Navigating to u-boot directory..."
cd u-boot

# Git's main branch might be named "master" or "main".
# This command checks out the correct remote branch.
echo "Checking out main branch..."
git fetch origin main
git checkout main

# Clean build directory before building
echo "Cleaning old build files..."
make distclean

# Configure for BeagleBone Black
echo "Configuring for BeagleBone Black (am335x_evm_defconfig)..."
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- am335x_evm_defconfig

# Build U-Boot with all available cores
echo "Starting U-Boot build..."
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-

echo "✅ Build xong U-Boot!"
ls -lh u-boot.img MLO || true
