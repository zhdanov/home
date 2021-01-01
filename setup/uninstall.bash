#!/bin/bash
cd "$(dirname "$0")"

./uninstall-purge.bash

minikube delete
pkill -f minikube
