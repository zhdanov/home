#!/bin/bash
cd "$(dirname "$0")"

. ./setup_def.bash

echo "ssh -p $HOME_SSH_PORT -L $1:127.0.0.1:$1 -f -C -q -N $HOME_USER_NAME@$HOME_SSH_HOST"
