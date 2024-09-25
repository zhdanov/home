#!/bin/bash

pushd /opt/my-opinion/
    git reset --hard
    git fetch origin
    git pull origin master

    pushd resource/2.4/
        autogen --vault=../ --out=. --tags=autogen,mind,films,dev,common,backup,monitoring,confidence,jobber --prefix=2.4 --no_tags_is_ok=true
    popd
popd
