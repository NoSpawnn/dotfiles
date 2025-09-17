#!/usr/bin/env bash

set -euxo pipefail

ensure_flatpaks() {
    local flatpaks=$(cat $(realpath $1) | tr '\n' ' ' )
}

ensure_flatpaks ./flatpaks.list

exit 0

# Install oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s

# Symlink dotfiles
stow .

# Setup distroboxes (see distrobox.ini)
distrobox-assemble create ./distrobox.ini -R
