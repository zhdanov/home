#!/bin/bash
pushd "$(dirname "$0")"

    . ../setup/setup_def.bash
    if [[ -f "../setup/setup_def_custom.bash" ]]; then
        . ../setup/setup_def_custom.bash
    fi

    # notepad directory
    if [[ ! -d "$HOME_CLOUD_DIR/notepad" ]]; then
        mkdir -p $HOME_CLOUD_DIR/notepad
    fi

    if [[ ! -f "$HOME/notepad" ]] && [[ ! -L "$HOME/notepad" ]]; then
        ln -s $HOME_CLOUD_DIR/notepad $HOME/notepad
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
  bind -x '\"\C-h\": fzf_path=`pwd`;cd \$HOME_CLOUD_DIR/notepad/;fzf_path_vim=\$(fzf);vim \$fzf_path_vim;cd -;history -s vim \$HOME_CLOUD_DIR/notepad/\$fzf_path_vim'
fi" >> $HOME/.bashrc
    fi

popd
