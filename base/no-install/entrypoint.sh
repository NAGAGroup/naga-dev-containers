#!/bin/bash

source $DEVENV/env.sh

sudo /sbin/sshd -D -p 2222 &

bash --login -c "$@"
