#!/bin/bash

sudo /sbin/sshd -D -p 2222 &

bash --login -c "$@"
