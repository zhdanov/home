#!/bin/bash

if kubectl -n production get statefulsets.apps | grep -q gitlab-statefulset; then
    kubectl -n production delete statefulsets.apps gitlab-statefulset
fi
