#!/usr/bin/env bash

cp ~/dotfiles/.zshrc ~/.zshrc
curl -s https://ohmyposh.dev/install.sh | bash -s

exec zsh
