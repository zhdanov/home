#!/bin/bash

function install_chrome_extension ()
{
    preferences_dir_path="/opt/google/chrome/extensions"
    pref_file_path="$preferences_dir_path/$1.json"
    upd_url="https://clients2.google.com/service/update2/crx"
    sudo mkdir -p "$preferences_dir_path"
    cat <<EOF | sudo tee $pref_file_path
{
  "external_update_url": "$upd_url"
}
EOF
}

if [[ ! -f "/etc/apt/sources.list.d/google-chrome.list" ]]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

    sudo apt -y install ./google-chrome-stable_current_amd64.deb

    rm google-chrome-stable_current_amd64.deb

    install_chrome_extension "eekailopagacbcdloonjhbiecobagjci" "Go Back With Backspace"
    install_chrome_extension "dbepggeogbaibhgnhhndojpepiihcmeb" "Vimium"
    install_chrome_extension "dcjichoefijpinlfnjghokpkojhlhkgl" "Notifier for Gmail"
    install_chrome_extension "omghfjlpggmjjaagoclmmobgdodcjboh" "Browsec"
    install_chrome_extension "gighmmpiobklfepjocnamgkkbiglidom" "Adblock"
fi
