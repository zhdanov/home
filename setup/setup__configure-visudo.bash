#!/bin/bash

if ! sudo grep -q '%sudo ALL=(ALL) NOPASSWD: ALL' /etc/sudoers; then
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
fi
