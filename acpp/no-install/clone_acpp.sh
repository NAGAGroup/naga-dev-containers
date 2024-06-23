#!/bin/bash

mkdir -p $PIXI_PROJECT_ROOT/acpp-files
sudo chown -R $(id -un):$(id -un) $PIXI_PROJECT_ROOT/acpp-files

if ! [ -d $PIXI_PROJECT_ROOT/acpp-files/src ]; then
	git clone --depth=1 --branch=v24.02.0 https://github.com/AdaptiveCpp/AdaptiveCpp $PIXI_PROJECT_ROOT/acpp-files/src
fi
