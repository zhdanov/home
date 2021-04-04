#!/bin/bash

HOME_USER_NAME=user
HOME_USER_EMAIL=user@email.loc
HOME_SSH_HOST=127.0.0.1
HOME_SSH_PORT=80
HOME_SOCKET_PORT=8123
HOME_MINIKUBE_CPU=3
HOME_MINIKUBE_MEM=6144
HOME_MINIKUBE_PV_SIZE=50Gi
HOME_MINIKUBE_DASHBOARD_PORT=8010
HOME_VIM_INDENT_JS=2
HOME_VIM_INDENT_CSS=2
HOME_VIM_INDENT_JSON=2
HOME_VIM_INDENT_PHP=4
HOME_VIM_INDENT_SHELL=4
HOME_REGISTRY=werf-registry.kube-system.svc.cluster.local
HOME_KUBECONTEXT=minikube
HOME_KUBECONFIG=$HOME/.kube/config
HOME_BACKUP_CRON="30 4 * * *"
HOME_SECOND_KEYBOARD_LAYOUT="ru"

HOME_SESSION_TYPE=local
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  HOME_SESSION_TYPE=remote/ssh
else
  case $(ps -o comm= -p $PPID) in
    sshd|*/sshd) HOME_SESSION_TYPE=remote/ssh;;
  esac
fi

if [[ -f "$HOME/setup/setup_def_custom.bash" ]]; then
    . $HOME/setup/setup_def_custom.bash
fi
