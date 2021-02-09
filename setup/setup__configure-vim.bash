#!/bin/bash

[[ ! -d $HOME/.vim/after/ftplugin ]] && mkdir -p $HOME/.vim/after/ftplugin
[[ ! -d $HOME/.vim/plugin ]] && mkdir -p $HOME/.vim/plugin
[[ ! -d $HOME/.vim/autoload ]] && mkdir -p $HOME/.vim/autoload

if [[ ! -f "$HOME/.vim/after/ftplugin/js.vim" ]]; then
    cat <<EOT >> $HOME/.vim/after/ftplugin/js.vim
    set tabstop=$HOME_VIM_INDENT_JS
    set shiftwidth=$HOME_VIM_INDENT_JS
EOT
fi

if [[ ! -f "$HOME/.vim/after/ftplugin/css.vim" ]]; then
    cat <<EOT >> $HOME/.vim/after/ftplugin/css.vim
set tabstop=$HOME_VIM_INDENT_CSS
set shiftwidth=$HOME_VIM_INDENT_CSS
EOT
fi

if [[ ! -f "$HOME/.vim/after/ftplugin/json.vim" ]]; then
    cat <<EOT >> $HOME/.vim/after/ftplugin/json.vim
set tabstop=$HOME_VIM_INDENT_JSON
set shiftwidth=$HOME_VIM_INDENT_JSON
EOT
fi

if [[ ! -f "$HOME/.vim/after/ftplugin/php.vim" ]]; then
    cat <<EOT >> $HOME/.vim/after/ftplugin/php.vim
set tabstop=$HOME_VIM_INDENT_PHP
set shiftwidth=$HOME_VIM_INDENT_PHP
EOT
fi

if [[ ! -f "$HOME/.vim/after/ftplugin/sh.vim" ]]; then
    cat <<EOT >> $HOME/.vim/after/ftplugin/sh.vim
set tabstop=$HOME_VIM_INDENT_SHELL
set shiftwidth=$HOME_VIM_INDENT_SHELL
EOT
fi

if [[ ! -f "$HOME/.vim/plugin/emmet.vim" ]]; then
    git clone https://github.com/mattn/emmet-vim.git

    pushd emmet-vim
        cp plugin/emmet.vim $HOME/.vim/plugin/
        cp autoload/emmet.vim $HOME/.vim/autoload/
        cp -a autoload/emmet $HOME/.vim/autoload/
    popd

    rm -rf emmet-vim
fi
