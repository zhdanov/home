#!/bin/bash

which helm > /dev/null || ( curl -L https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash )
