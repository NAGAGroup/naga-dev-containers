ARG BASE_IMAGE=ghcr.io/nagagroup/naga-dev:llvm-sycl-no-install-latest

FROM $BASE_IMAGE

LABEL org.opencontainers.image.source=https://github.com/NAGAGroup/naga-dev-containers

ARG DOCKER_BUILD=false

ARG CMAKE_BUILD_PARALLEL_LEVEL=8

RUN echo Installing devenv packages
RUN if [ "$DOCKER_BUILD" = "false" ]; then pixi run --manifest-path $DEVENV/pixi.toml build-llvm; fi
RUN if [ "$DOCKER_BUILD" = "false" ]; then pixi run --manifest-path $DEVENV/pixi.toml install-llvm; fi
RUN if [ "$DOCKER_BUILD" = "true" ]; then pixi run --manifest-path $DEVENV/pixi.toml install-llvm-and-cleanup; fi
