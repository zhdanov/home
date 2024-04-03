#!/bin/bash
pushd "$(dirname "$0")"

    cd /home/$USER/ && wget --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3" -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

popd
