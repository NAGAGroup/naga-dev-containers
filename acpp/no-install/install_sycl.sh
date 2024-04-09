#!/bin/bash
set -e
set -x

cmake --install $PIXI_PROJECT_ROOT/acpp-files/src/build --prefix /opt/acpp

chmod -R 777 /opt/acpp
