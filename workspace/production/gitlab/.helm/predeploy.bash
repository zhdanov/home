#!/bin/bash

if kubectl -n production get deployments.apps | grep -q gitlab-deployment; then
    kubectl -n production delete deployments.apps gitlab-deployment
fi
