#!/bin/bash
set -eux
cd "$(dirname "$0")"

. setup__nodejs.bash

sudo npm install commitizen -g
