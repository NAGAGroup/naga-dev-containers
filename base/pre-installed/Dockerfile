ARG BASE_IMAGE=ghcr.io/nagagroup/naga-dev:base-no-install-latest

FROM $BASE_IMAGE

LABEL org.opencontainers.image.source=https://github.com/NAGAGroup/naga-dev-containers

# Install pixi environment
RUN pixi install --manifest-path $DEVENV/pixi.toml

