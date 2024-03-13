#!/bin/bash
set -e
set -x

export LD_LIBRARY_PATH=""
export CUDA_LIB_PATH=$PIXI_PROJECT_ROOT/.pixi/envs/default/lib/stubs
export CC=gcc
export CXX=g++

source /runtimes/oneapi-tbb/env/vars.sh

mkdir -p llvm-files/build
cd $PIXI_PROJECT_ROOT/llvm-files
python3 src/buildbot/configure.py -w $PIXI_PROJECT_ROOT/llvm-files \
	-s src -o build -t Release \
	--cuda \
	--cmake-opt="-DLLVM_INSTALL_UTILS=ON" \
	--cmake-opt="-DSYCL_PI_TESTS=OFF" \
	--cmake-opt="-DLLVM_ENABLE_ASSERTIONS=OFF" \
	--cmake-opt="-DCMAKE_SYSTEM_PREFIX_PATH=$PIXI_PROJECT_ROOT/.pixi/envs/default" \
	--cmake-opt="-DLLVM_ENABLE_WERROR=OFF" \
	--cmake-opt="-DLLVM_ENABLE_WARNINGS=OFF" \
	--llvm-external-projects="clang;clang-tools-extra;compiler-rt"
