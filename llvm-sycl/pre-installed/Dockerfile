ARG BASE_IMAGE=ghcr.io/nagagroup/naga-dev:llvm-sycl-no-install-latest

FROM $BASE_IMAGE

LABEL org.opencontainers.image.source=https://github.com/NAGAGroup/naga-dev-containers

# #  Add image files to the container
# COPY image-files.tar.gz /tmp
# RUN mkdir -p /tmp/image-files
# RUN tar -xvzf /tmp/image-files.tar.gz -C /tmp/image-files && \
#   sudo chown -R gpu-dev:gpu-dev /tmp/image-files && \
#   cp -r /tmp/image-files/etc/* /etc && \
#   cp -r /tmp/image-files/.pixi /home/gpu-dev/.local/share/devenv && \
#   cp -r /tmp/image-files/runtimes /runtimes && \
#   sudo rm -rf /tmp/image-files* 
#
# RUN sudo chown -R root:root /etc/OpenCL/ 
# RUN sudo chown -R root:root /runtimes
# RUn sudo chmod +x /runtimes/oneapi-tbb/env/vars.sh

ARG DOCKER_BUILD=false

RUN bash --login -c "echo Installing devenv packages"
RUN if [ "$DOCKER_BUILD" = "false" ]; then bash --login -c "pixi run --manifest-path /home/gpu-dev/.local/share/devenv/pixi.toml build-llvm"; fi
RUN if [ "$DOCKER_BUILD" = "false" ]; then bash --login -c "pixi run --manifest-path /home/gpu-dev/.local/share/devenv/pixi.toml install-llvm"; fi
RUN if [ "$DOCKER_BUILD" = "true" ]; then bash --login -c "pixi run --manifest-path /home/gpu-dev/.local/share/devenv/pixi.toml install-llvm-and-cleanup"; fi
