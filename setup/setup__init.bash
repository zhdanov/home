#!/bin/bash
cd $HOME
sudo apt update -y && sudo apt install -y git && git init
git remote add origin https://github.com/zhdanov/home
git fetch origin
git checkout -b master origin/master
