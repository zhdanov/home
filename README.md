# Welcome Home
Hi! My name is Yuriy Zhdanov. This is my home directory for deploying the desktop environment. Ubuntu 20.04.

## Structure

### Dotfiles
```
.bashrc_home  aliases, environment variables
.gitconfig    aliases, settings
.tmux.conf    hotkeys, options
.vimrc        nothing outstanding
```

### Packages set
```
i3       tiling window manager
tmux     terminal multiplexer
vim      text editor
htop     better than top
fzf      fuzzy finder
ripgrep  better than grep
ncdu     better than du
docker   containers
kubectl  container orchestration
```

## Installation

### Dotfiles
1. Init home directory
```bash
cd $HOME
git init
git remote add origin https://github.com/zhdanov/home
git fetch origin
git checkout -b main origin/main
```
2. Change ./setup/setup_def.bash
```bash
HOME_USER_NAME=torvalds
HOME_USER_EMAIL=torvalds@linux-foundation.org
...
```
3. Run setup
```bash
./setup/setup__dotfiles.bash
```

### Workspace (optional)
```bash
./setup/setup.bash
```

## License
The home directory is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
