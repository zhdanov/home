#!/bin/bash

if [[ ! -f "/etc/apt/sources.list.d/yandex-disk.list" ]]; then
    echo "deb http://repo.yandex.ru/yandex-disk/deb/ stable main" | sudo tee -a /etc/apt/sources.list.d/yandex-disk.list > /dev/null && wget http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG -O- | sudo apt-key add - && sudo apt-get update && sudo apt-get install -y yandex-disk

    cat << EOF
    ==== Yandex Disk ====
    == optional ==
vim $HOME/.config/yandex-disk/config.cfg
exclude-dirs=home,tmp
read-only="true"
overwrite="true"
    == /optional ==
EOF

    yandex-disk setup

    # notepad directory
    if [[ ! -d "$HOME/Yandex.Disk/notepad" ]]; then
        mkdir -p $HOME/Yandex.Disk/notepad
    fi

    if [[ ! -f "$HOME/notepad" ]] && [[ ! -L "$HOME/notepad" ]]; then
        ln -s $HOME/Yandex.Disk/notepad $HOME/notepad
    fi

    # Ctrl+h fuzzy search in the notepad
    # Ctrl+p fuzzy search in the history
    if ! grep -q "# fzf + rg" $HOME/.bashrc; then
        echo "
# fzf + rg￼
export FZF_DEFAULT_COMMAND='rg --files --no-ignore -g \"!{.git,node_modules,vendor}/*\" 2> /dev/null'
export FZF_CTRL_T_COMMAND=\"\$FZF_DEFAULT_COMMAND\"
if [ -t 1 ]
then
  bind -x '\"\C-p\": fzf_path=\$(fzf); vim \$fzf_path; history -s vim \$fzf_path'
  bind -x '\"\C-h\": fzf_path=`pwd`;cd \$HOME/Yandex.Disk/notepad/;fzf_path_vim=\$(fzf);vim \$fzf_path_vim;cd \$fzf_path;history -s vim \$HOME/Yandex.Disk/notepad/\$fzf_path_vim'
fi" >> $HOME/.bashrc
    fi

fi
