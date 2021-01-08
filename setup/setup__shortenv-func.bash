#!/bin/bash

function shortenv()
{
    if [[ $1 == "production" ]]
    then
        shortenv=prod
    elif [[ $1 == "development" ]]
    then
        shortenv=dev
    elif [[ $1 == "testing" ]]
    then
        shortenv=test
    elif [[ $1 == "staging" ]]
    then
        shortenv=stage
    else
        shortenv=$1
    fi
}
