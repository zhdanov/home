# Welcome

![](https://raw.githubusercontent.com/zhdanov/home/main/Pictures/logo/logo-readme.png)

Hi! My name is [Yuriy Zhdanov](https://jupiter.solutions/). This project is my home directory for deploying the desktop environment. Infrastructure as code. Ubuntu 20.04. See the [documentation](https://jupiter.solutions/home/docs/).

Last stable version: [1.4.0](https://github.com/zhdanov/home/releases/tag/1.4.0)

## Getting started

1. Init home directory

```bash
cd $HOME
git init
git remote add origin https://github.com/zhdanov/home
git fetch origin
git checkout -b main origin/main
```

2. Configure [./setup/setup_def.bash](https://github.com/zhdanov/home/blob/main/setup/setup_def.bash) (or create ./setup/setup_def_custom.bash)

```bash
HOME_USER_NAME=torvalds
HOME_USER_EMAIL=torvalds@linux-foundation.org
...
```

3. Run [./setup/setup.bash](https://github.com/zhdanov/home/blob/main/setup/setup.bash)

```bash
./setup/setup.bash slave   # install/update software, dotfiles, configure system
./setup/setup.bash master  # start minikube

# optional
./setup__cloud-drive.bash  # Yandex Disk, Dropbox
./setup__notepad.bash      # fuzzy search, ripgrep
./setup__backup.bash       # night backup
./setup__commitizen.bash   # commitizen
```

Then you can [create a new project](https://jupiter.solutions/home/docs/how-to/how-to-create-a-new-project/) and [configure backup](https://jupiter.solutions/home/docs/backup/).

## Documentation

[Getting started](https://jupiter.solutions/home/docs/)  
[Project structure](https://jupiter.solutions/home/docs/project-structure/)  
[Packages set](https://jupiter.solutions/home/docs/packages-set/)  
[How to create a new project?](https://jupiter.solutions/home/docs/how-to/how-to-create-a-new-project/)  
[Auto-backup to the cloud](https://jupiter.solutions/home/docs/backup/)  
[Other (optional)](https://jupiter.solutions/home/docs/other/)

## External documentation

[bash](https://www.gnu.org/software/bash/manual/bash.html)  
[i3wm](https://i3wm.org/docs/)  
[helm](https://helm.sh/docs/)  
[kubernetes](https://kubernetes.io/docs/home/)  
[werf](https://werf.io/documentation/v1.2/quickstart.html)  
[bem](https://en.bem.info/methodology/key-concepts/)

## This repository was inspired

[i3wm screencast](https://youtu.be/Wx0eNaGzAZU)  
[Unix is my ide](https://mkaz.blog/code/unix-is-my-ide/)  
[Home .git](https://martinovic.blog/post/home_git/)  
[Linux Desktop Setup](https://hookrace.net/blog/linux-desktop-setup/)

## License

The home directory is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
