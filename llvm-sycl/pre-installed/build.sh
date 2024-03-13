#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.
set -x # Print commands and their arguments as they are executed.

# the pixi directory is a bit different as the entrypoint needs rw access to it
# so we separate it, and manually set the permissions
if ! [ -d ".pixi" ]; then
	mkdir -p .pixi
	chmod -R a+rwx .pixi
fi

mkdir -p llvm-files
mkdir -p etc/OpenCL/vendors/
mkdir -p runtimes

CONTAINER_COMMAND="$1"
BUILD_IMAGE="$2"

$CONTAINER_COMMAND run \
	--rm \
	-it \
	--security-opt=label=disable \
	-v $PWD/llvm-files:/home/gpu-dev/.local/share/devenv/llvm-files:rw \
	-v $PWD/.pixi/:/home/gpu-dev/.local/share/devenv/.pixi:rw \
	-v $PWD/etc/OpenCL:/etc/OpenCL:rw \
	-v $PWD/runtimes:/runtimes:rw \
	$BUILD_IMAGE \
	"pixi run --manifest-path \$PIXI_PROJECT_MANIFEST install-llvm"

IMAGE_TAG="$3"

mkdir -p image-files
cp -r etc image-files/etc
cp -r .pixi image-files/.pixi
cp -r runtimes image-files/runtimes
tar -czf image-files.tar.gz image-files

$CONTAINER_COMMAND build . -t $IMAGE_TAG --build-arg BASE_IMAGE=$BUILD_IMAGE -v $PWD:/tmp/builddir:Z
