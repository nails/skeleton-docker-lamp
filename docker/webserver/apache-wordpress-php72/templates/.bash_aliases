#!/bin/bash

# Alias the crontab command so we can copy the contents of the crontab after it has been edited back to the host
alias crontab="mycrontab"
mycrontab () {
    ARG="$1$2"
    if [ "$ARG" == "-e" ]; then
        command crontab -e
        echo "Syncing changes to host"
        command crontab -l > ~/crontab
    else
        command crontab $1 $2
    fi
}
