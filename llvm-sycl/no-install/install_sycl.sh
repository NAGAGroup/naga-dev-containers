#!/bin/bash
set -e
set -x

cmake --build $PIXI_PROJECT_ROOT/llvm-files/build --target deploy-sycl-toolchain
# cmake --build /usr/local/sycl --target utils/FileCheck/install
# cmake --build /usr/local/sycl --target utils/count/install
# cmake --build /usr/local/sycl --target utils/not/install
# cmake --build /usr/local/sycl --target utils/lit/install
# cmake --build /usr/local/sycl --target utils/llvm-lit/install
# cmake --build /usr/local/sycl --target install-llvm-size
# cmake --build /usr/local/sycl --target install-llvm-cov
# cmake --build /usr/local/sycl --target install-llvm-profdata
mkdir -p /opt/llvm-sycl
cmake --install $PIXI_PROJECT_ROOT/llvm-files/build --prefix /opt/llvm-sycl

chmod -R 777 /opt/llvm-sycl

echo "LLVM SYCL installed! To enable Intel OpenCL drivers, run \"source \$HOME/.bashrc\""
