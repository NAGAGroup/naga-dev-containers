#!/bin/bash

# For more information on where this script
# came from, see devops/containers/ubuntu2204_intel_drivers.Dockerfile
# in llvm sycl repo

set -e
set -x

export compute_runtime_tag=latest
export igc_tag=latest
export cm_tag=latest
export level_zero_tag=latest
export tbb_tag=latest
export fpgaemu_tag=latest
export cpu_tag=latest

if ! [ -d /etc/OpenCL/vendors ]; then
	sudo mkdir -p /etc/OpenCL/vendors
fi
sudo chown $(id -un):$(id -gn) /etc/OpenCL/vendors
export INSTALL_LOCATION=/runtimes

if [ -d $INSTALL_LOCATION ]; then
	sudo rm -rf $INSTALL_LOCATION/*
fi
sudo mkdir -p $INSTALL_LOCATION
sudo chown -R $(id -un):$(id -gn) $INSTALL_LOCATION

sh $PIXI_PROJECT_ROOT/llvm-files/src/devops/scripts/install_drivers.sh --fpga-emu

sudo chown root:root /etc/OpenCL/vendors
sudo chown -R root:root $INSTALL_LOCATION

ln -sf /etc/OpenCL/vendors/* $PIXI_PROJECT_ROOT/.pixi/envs/default/etc/OpenCL/vendors
