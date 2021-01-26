#!/bin/bash
pushd "$(dirname "$0")"

    [ ! -d /opt/dropbox ] && mkdir /opt/dropbox/

    wget https://www.dropbox.com/download?plat=lnx.x86_64 -O dropbox-linux.tar.gz

    if [ -f dropbox-linux.tar.gz ]
    then
        tar xvf dropbox-linux.tar.gz --strip 1 -C /opt/dropbox
        rm dropbox-linux.tar.gz
    fi

popd
