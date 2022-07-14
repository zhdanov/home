#!/bin/bash
pushd "$(dirname "$0")"

    . setup_def.bash

    werf host cleanup
    werf host purge

    for image in `docker images | grep werf-images | awk '{print $3}'`; do docker image rm $image; done
    for image in `docker images | grep werf-stages | awk '{print $3}'`; do docker image rm $image; done
    for image in `docker images | grep werf-managed | awk '{print $3}'`; do docker image rm $image; done

popd
