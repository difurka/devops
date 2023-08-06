#!/bin/bash

if [ $# -eq 1 ];
then
    if [[ "$1" =~ ^[[:digit:]]+$ ]];
    then
        echo "Incorrect input"
    else
        echo "$1"
    fi
else
    echo "Incorrect number of parameters"
fi
