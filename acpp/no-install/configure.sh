#!/bin/bash
set -e
set -x

mkdir -p $PIXI_PROJECT_ROOT/acpp-files/src/build
cd $PIXI_PROJECT_ROOT/acpp-files/src/build
cmake -DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=$PIXI_PROJECT_ROOT/.pixi/envs/default \
	-DCMAKE_CXX_COMPILER=clang++ \
	-DWITH_ROCM_BACKEND=OFF \
	-DWITH_CUDA_BACKEND=ON \
	-DWITH_OPENCL_BACKEND=ON \
	-DLLVM_DIR=$PIXI_PROJECT_ROOT/.pixi/envs/default/lib/cmake/llvm \
	..
