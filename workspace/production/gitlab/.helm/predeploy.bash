#!/bin/bash

if kubectl -n production get statefulsets.apps | grep -q gitlab-prod; then
    kubectl -n production delete statefulsets.apps gitlab-prod
fi
