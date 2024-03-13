ARG BASE_IMAGE=ghcr.io/nagagroup/naga-dev:base-no-install-latest

FROM $BASE_IMAGE

LABEL org.opencontainers.image.source=https://github.com/NAGAGroup/naga-dev-containers

RUN bash --norc -c "/home/gpu-dev/.cargo/bin/pixi add --no-install --manifest-path /home/gpu-dev/.local/share/devenv/pixi.toml \ 
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
  pocl"

RUN echo "if [ -f /runtimes/oneapi-tbb/env/vars.sh ]; then source /runtimes/oneapi-tbb/env/vars.sh; fi" >> /home/gpu-dev/.bashrc

# Installation tasks specific to the image
COPY ./*.sh /home/gpu-dev/.local/share/devenv/
COPY ./tasks.txt /tmp/tasks.txt
RUN cat /tmp/tasks.txt >> /home/gpu-dev/.local/share/devenv/pixi.toml && sudo rm /tmp/tasks.txt
RUN sudo chown -R gpu-dev:gpu-dev /home/gpu-dev/.local/share/devenv
