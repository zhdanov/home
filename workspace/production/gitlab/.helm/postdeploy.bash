#!/bin/bash

sudo sed -i -e '/^.*gitlab\.loc.*$/d' /etc/hosts
echo `minikube ip`" gitlab.loc" | sudo tee -a /etc/hosts
