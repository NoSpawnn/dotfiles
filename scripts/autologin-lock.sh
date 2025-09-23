#!/bin/bash

export SDDM_TEST=$(pgrep -xa sddm-helper)
[[ $SDDM_TEST == *"--autologin"* ]] && loginctl lock-session
