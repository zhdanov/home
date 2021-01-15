#!/bin/bash

sudo sed -i -e "/^.*sandbox-$shortenv\.loc.*$/d" /etc/hosts
echo `minikube ip`" sandbox-$shortenv.loc" | sudo tee -a /etc/hosts
