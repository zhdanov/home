# Welcome

![](https://raw.githubusercontent.com/zhdanov/home/master/Pictures/logo/logo-readme.png)

This project is a collection of bootstrap scripts and dotfiles for configuring and provisioning my desktop environment on Ubuntu (20.04/22.04/24.04). Instead of full IaC, it focuses on lightweight, reproducible automation for setting up a new workstation.

Last stable version: [2.0.0](https://github.com/zhdanov/home/releases/tag/2.0.0).

## Getting started

1. Init home directory

```bash
curl -L https://raw.githubusercontent.com/zhdanov/home/master/setup/setup__init.bash | bash
```

2. Configure [./setup/setup_def.bash](https://github.com/zhdanov/home/blob/master/setup/setup_def.bash) (or create ./setup/setup_def_custom.bash)

```bash
HOME_USER_NAME=torvalds
HOME_USER_EMAIL=torvalds@linux-foundation.org
...
```

3. Run [./setup/setup.bash](https://github.com/zhdanov/home/blob/master/setup/setup.bash)

```bash
# additional scripts inside the setup directory
./setup__slave.bash        # desktop environment
./setup__ctr_debian.bash   # debian container (minimal setup)
./setup__master.bash       # standalone bare-metal host
./setup__cloud-drive.bash  # Yandex Disk, Dropbox
./setup__notepad.bash      # fuzzy search, ripgrep
./setup__backup.bash       # night backup
```

## This repository was inspired

[i3wm screencast](https://youtu.be/Wx0eNaGzAZU)  
[Unix is my ide](https://mkaz.blog/code/unix-is-my-ide/)  
[Home .git](https://martinovic.blog/posts/2019-06-09-home-git/)  
[Linux Desktop Setup](https://hookrace.net/blog/linux-desktop-setup/)

## License

The home directory is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
