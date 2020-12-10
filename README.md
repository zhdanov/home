# Welcome Home
Hi! My name is Yuriy Zhdanov. This is my home directory. Ubuntu 20.04.

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
3. Run setup
```bash
./setup/setup__dotfiles.bash
```

### Minikube (optional)
```bash
./setup/setup__minikube.bash
```

## All (optional)
```bash
./setup/setup.bash


## License
The home directory is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
