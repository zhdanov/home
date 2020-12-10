#!/bin/bash

sudo apt clean
sudo apt -y update
sudo apt -y upgrade

sudo apt -y install vim git openssh-server nodejs npm tmux curl
