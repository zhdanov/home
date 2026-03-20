#!/bin/bash
cd $HOME
sudo apt-get update -y && sudo apt-get install -y git && git init
git remote add origin https://github.com/zhdanov/home
git fetch origin
git checkout -b master origin/master
