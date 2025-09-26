#!/usr/bin/env bash
set -euo pipefail

# This script is designed for a clean CI environment.
# It always performs a fresh clone to ensure a consistent build.

# Remove existing u-boot directory if it exists to ensure a clean slate.
if [ -d "u-boot" ]; then
    echo "Directory u-boot exists. Removing it for a fresh clone."
    rm -rf "u-boot"
fi

echo "Cloning U-Boot repository..."
git clone https://source.denx.de/u-boot/u-boot.git

echo "Navigating to u-boot directory..."
cd u-boot

# Some repositories use 'master', others use 'main'.
# This command first tries to fetch 'main' and then 'master'.
echo "Fetching and checking out the main branch..."
git fetch origin main || git fetch origin master

# Use `git checkout` to switch to the fetched branch.
# We'll use a logical OR (||) to try `main` first, and if that fails, try `master`.
git checkout main || git checkout master

# Clean the build directory from any previous configurations
echo "Cleaning old build files..."
make distclean

# Configure for BeagleBone Black
echo "Configuring for BeagleBone Black (am335x_evm_defconfig)..."
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- am335x_evm_defconfig

# Build U-Boot using all available CPU cores
echo "Starting U-Boot build..."
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-

echo "✅ U-Boot build complete!"
# List the built artifacts
ls -lh u-boot.img MLO || true
