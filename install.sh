#!/usr/bin/env bash

set -euxo pipefail

# Install oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s

# Symlink dotfiles
stow zsh
stow hyprland
# Explicitly create the zed config dir, else stow will symlink every folder
mkdir -p $HOME/.var/app/dev.zed.Zed/config/zed && stow zed

distrobox assemble create -R --file distrobox.ini
