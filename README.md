# Welcome Home
Hi! My name is [Yuriy Zhdanov](https://jupiter.solutions/). This project is my home directory for deploying the desktop environment. Ubuntu 20.04.

Last stable version: [1.2.0](https://github.com/zhdanov/home/releases/tag/1.2.0)

## Project structure

### Dotfiles
```
.bashrc_home  aliases, environment variables
.gitconfig    aliases, settings
.tmux.conf    hotkeys, options
.vimrc        nothing outstanding
```

### Directories
```
Pictures    background image
bin         useful scripts
data-store  projects directory volumes (mount to minikube)
setup       install and uninstall scripts
workspace   environment directories for symbolic links from projects
```

### Packages set

app | description
--- | ---
[i3](https://github.com/i3/i3) | tiling window manager
[tmux](https://github.com/tmux/tmux) | terminal multiplexer
[vim](https://github.com/vim/vim) | text editor
[htop](https://github.com/htop-dev/htop/) | better than top
[fzf](https://github.com/junegunn/fzf) | fuzzy finder
[ripgrep](https://github.com/BurntSushi/ripgrep) | better than grep
[ncdu](https://dev.yorhel.nl/ncdu) | better than du
[nemo](https://github.com/linuxmint/nemo) | better than nautilus
[docker](https://github.com/docker) | containers
[kubectl](https://github.com/kubernetes/kubectl) | container orchestration
[minikube](https://github.com/kubernetes/minikube) | local kubernetes cluster
[werf](https://github.com/werf/werf) | build and deploy projects

```
# browsers
google-chrome
firefox
opera
yandex-browser

# other
ttf-mscorefonts
kate
fbreader
audacity
growisofs
peek
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
./setup/setup.bash slave   # for workstation
./setup/setup.bash master  # for minikube
```

### Auto-backup to the cloud
1. Make backup-list files. Example:
```bash
~/data-store/gitlab-prod/backup-list.txt
    gitlab-config                    # pvc-directory name example
    /path/to/backup.bash             # execute this script with parameter $HOME_USER_NAME
    user@host:/path/to/backup/daily  # scp $NOW.zip from the daily directory
```
2. Change HOME_BACKUP_CRON in:
```bash
setup/setup_def.bash
or setup/setup_def_custom.bash
```

### Other (optional)
```bash
# deploy workspace
./setup/setup__workspace-deploy.bash

# minikube dashboard
./setup/setup__dashboard.bash

# connect to minikube dashboard
./setup/setup__dashboard-connect-through-ssh-tunnel.bash

# ssh tunnel for browser
./setup/setup__ssh-tunnel-for-browser.ssh

# for contribute this repo (nodejs+commitizen)
./setup/setup__commitizen.bash

# yandex-disk, dropbox
./setup/setup__cloud-drive.bash

# make symbolic links in ~/develop/ and ~/workspace/
# sources: ~/Yandex.Disk/active-project-list/%repo% and %repo%/namespace-list.txt
./setup/setup__workspace-active-projects.bash

# clean werf images
./setup/uninstall-purge.bash

# uninstall
./setup/uninstall.bash
```

## License
The home directory is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
