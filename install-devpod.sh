#!/usr/bin/env bash

# Install script for devpods/devcontainers

cp ~/dotfiles/.zshrc ~/.zshrc

curl -s https://ohmyposh.dev/install.sh | bash -s
cp -r ~/dotfiles/.config/ohmyposh ~/.config/ohmyposh
