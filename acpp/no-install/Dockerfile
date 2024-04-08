ARG BASE_IMAGE=ghcr.io/nagagroup/naga-dev:base-no-install-latest

FROM $BASE_IMAGE

LABEL org.opencontainers.image.source=https://github.com/NAGAGroup/naga-dev-containers

RUN pixi add --no-install --manifest-path $DEVENV/pixi.toml \ 
  llvmdev \ 
  llvm-tools \ 
  clang-tools \ 
  clangdev \ 
  clang \ 
  clangxx \ 
  compiler-rt \ 
  boost \ 
  llvm-spirv \ 
  spirv-tools \ 
  spirv-headers \ 
  libllvmspirv \ 
  openmp \ 
  intel-opencl-rt

# Installation tasks specific to the image
COPY ./*.sh $DEVENV/
COPY ./tasks.txt /tmp/tasks.txt
RUN cat /tmp/tasks.txt >> $DEVENV/pixi.toml && sudo rm /tmp/tasks.txt

ENV PATH=/opt/acpp/bin:$PATH
