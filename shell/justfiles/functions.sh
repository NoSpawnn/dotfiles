#!/usr/bin/env bash

choose() {
    PS3="$1"
    shift
    select choice in "$@"
    do
        echo "$choice"
        break
    done
}
