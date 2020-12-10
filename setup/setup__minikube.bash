#!/bin/bash
cd "$(dirname "$0")"

. setup_def.bash
. setup__packages.bash
. setup__nodejs.bash
. setup__commitizen.bash

. setup__configure-ssh.bash
