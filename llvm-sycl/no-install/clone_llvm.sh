#!/bin/bash

mkdir -p $PIXI_PROJECT_ROOT/llvm-files
sudo chown -R $(id -un):$(id -un) $PIXI_PROJECT_ROOT/llvm-files

if ! [ -d $PIXI_PROJECT_ROOT/llvm-files/src ]; then
	git clone https://github.com/intel/llvm -b sycl-web/sycl-latest-good --depth=1 $PIXI_PROJECT_ROOT/llvm-files/src
fi
