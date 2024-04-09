ARG BASE_IMAGE=ghcr.io/nagagroup/naga-dev:base-no-install-latest

FROM $BASE_IMAGE

LABEL org.opencontainers.image.source=https://github.com/NAGAGroup/naga-dev-containers

RUN pixi add --no-install --manifest-path $DEVENV/pixi.toml \ 
  cffi \ 
  ocl-icd-system \ 
  libva-utils \ 
  libva \ 
  procps-ng \ 
  spirv-tools \ 
  spirv-headers \ 
  libllvmspirv \ 
  libvulkan-loader \ 
  libvulkan-headers \ 
  vulkan-tools \ 
  vulkan-headers \ 
  jq \ 
  intel-opencl-rt \ 
  pocl

RUN echo "if [ -f /runtimes/oneapi-tbb/env/vars.sh ]; then source /runtimes/oneapi-tbb/env/vars.sh; fi" >> $DEVENV/env.sh

# Installation tasks specific to the image
COPY ./*.sh $DEVENV/
COPY ./tasks.txt /tmp/tasks.txt
RUN cat /tmp/tasks.txt >> $DEVENV/pixi.toml && sudo rm /tmp/tasks.txt

ENV PATH=/opt/llvm-sycl/bin:$PATH

COPY env.sh $DEVENV/env.sh
