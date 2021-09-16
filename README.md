# Welcome

![](https://raw.githubusercontent.com/zhdanov/home/main/Pictures/logo/logo-readme.png)

Hi! My name is [Yuriy Zhdanov](https://jupiter.solutions/). This project is my home directory for deploying the desktop environment. Ubuntu 20.04.

Last stable version: [1.2.0](https://github.com/zhdanov/home/releases/tag/1.2.0)

[Documentation](https://jupiter.solutions/home/docs/)

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
./setup/setup.bash slave   # for workstation
./setup/setup.bash master  # for minikube
```

Then you can [create a new project](https://jupiter.solutions/home/docs/how-to/how-to-create-a-new-project/) and [configure backup](https://jupiter.solutions/home/docs/backup/).

## License
The home directory is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
