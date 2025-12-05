# Welcome

![](https://raw.githubusercontent.com/zhdanov/home/main/Pictures/logo/logo-readme.png)

Hi! My name is [Yuriy Zhdanov](https://jupiter.solutions/). This project is my home directory for deploying the desktop environment. Infrastructure as code. Ubuntu 20.04/22.04/24.04.

Last stable version: [1.5.0](https://github.com/zhdanov/home/releases/tag/1.5.0)

## Getting started

1. Init home directory

```bash
curl -L https://raw.githubusercontent.com/zhdanov/home/main/setup/setup__init.bash | bash
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
./setup/setup.bash vbox    # setup "slave" without desktop features
./setup/setup.bash master  # start minikube

# optional
./setup__cloud-drive.bash  # Yandex Disk, Dropbox
./setup__notepad.bash      # fuzzy search, ripgrep
./setup__backup.bash       # night backup

# hosting (debian 11)
curl -sSL https://raw.githubusercontent.com/zhdanov/home/main/setup/setup__hosting-debian-11.bash | bash
```

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
