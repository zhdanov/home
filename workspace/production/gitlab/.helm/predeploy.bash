#!/bin/bash

if kubectl -n gitlab-prod get statefulsets.apps | grep -q gitlab-prod; then
    kubectl -n production delete statefulsets.apps gitlab-prod
fi
