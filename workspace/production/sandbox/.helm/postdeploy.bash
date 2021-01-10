#!/bin/bash

sudo sed -i -e '/^.*sandbox-prod.loc\.loc.*$/d' /etc/hosts
echo `minikube ip`" sandbox-prod.loc" | sudo tee -a /etc/hosts
