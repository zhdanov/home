#!/bin/bash
pushd "$(dirname "$0")"

    [ ! -d /opt/dropbox ] && mkdir /opt/dropbox/

    wget --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3" -O dropbox-linux.tar.gz https://www.dropbox.com/download?plat=lnx.x86_64

    if [ -f dropbox-linux.tar.gz ]
    then
        tar xvf dropbox-linux.tar.gz --strip 1 -C /opt/dropbox
        rm dropbox-linux.tar.gz
    fi

popd
