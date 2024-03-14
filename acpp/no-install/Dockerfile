ARG BASE_IMAGE=ghcr.io/nagagroup/naga-dev:base-no-install-latest

FROM $BASE_IMAGE

LABEL org.opencontainers.image.source=https://github.com/NAGAGroup/naga-dev-containers

RUN bash --norc -c "/home/gpu-dev/.cargo/bin/pixi add --no-install --manifest-path /home/gpu-dev/.local/share/devenv/pixi.toml \ 
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
  intel-opencl-rt"

# Installation tasks specific to the image
COPY ./*.sh /home/gpu-dev/.local/share/devenv/
COPY ./tasks.txt /tmp/tasks.txt
RUN cat /tmp/tasks.txt >> /home/gpu-dev/.local/share/devenv/pixi.toml && sudo rm /tmp/tasks.txt
RUN sudo chown -R gpu-dev:gpu-dev /home/gpu-dev/.local/share/devenv
