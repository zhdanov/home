#!/bin/bash

if ! sudo grep -q '%sudo ALL=(ALL) NOPASSWD: ALL' /etc/sudoers; then
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
fi

if ! sudo grep -q '^incus-root ' /etc/sudoers; then
    echo "incus-root ALL=(ALL) PASSWD: ALL" | sudo tee -a /etc/sudoers
fi
