#!/bin/bash
set -e
set -x

source /runtimes/oneapi-tbb/env/vars.sh

cmake --build $PIXI_PROJECT_ROOT/llvm-files/build
#cmake --build /usr/local/sycl --target check-llvm
#cmake --build /usr/local/sycl --target check-clang
#cmake --build /usr/local/sycl --target check-sycl
#cmake --build /usr/local/sycl --target check-llvm-spirv
#cmake --build /usr/local/sycl --target check-xptifw
#cmake --build /usr/local/sycl --target check-libclc
#cmake --build /usr/local/sycl --target check-libdevice
