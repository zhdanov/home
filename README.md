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
nemo     better than nautilus
docker   containers
kubectl  container orchestration

browsers:
google-chrome
firefox
yandex-browser

also:
ttf-mscorefonts
kate
fbreader
audacity
dbeaver
```

## Installation

### Workspace
1. Init home directory
```bash
cd $HOME
git init
git remote add origin https://github.com/zhdanov/home
git fetch origin
git checkout -b main origin/main
```
2. Change ./setup/setup_def.bash (or create setup/setup_def_custom.bash)
```bash
HOME_USER_NAME=torvalds
HOME_USER_EMAIL=torvalds@linux-foundation.org
...
```
3. Run setup
```bash
./setup/setup.bash
```

### Other (optional)
```bash
# deploy workspace
./setup/setup__workspace-deploy.bash

# minikube dashboard
./setup/setup__dashboard.bash

# connect to minikube dashboard
./setup/setup__dashboard-connect-through-ssh-tunnel.bash

# for contribute this repo (nodejs+commitizen)
./setup/setup__commitizen.bash

# notepad
./setup/setup__notepad.bash

# uninstall
./setup/uninstall.bash
```

## License
The home directory is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
