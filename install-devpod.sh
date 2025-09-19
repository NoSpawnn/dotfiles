#!/usr/bin/env bash

# Install script for devpods/devcontainers

SHELL_CONF_DIR="$HOME/dotfiles/shell"

cp $SHELL_CONF_DIR/.zshrc ~/.zshrc

curl -s https://ohmyposh.dev/install.sh | bash -s
cp -r $SHELL_CONF_DIR/.config/ohmyposh ~/.config/ohmyposh
