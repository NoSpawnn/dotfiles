#!/usr/bin/env bash

set -euxo pipefail

# Install oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s

# Symlink dotfiles
stow .

# Setup distroboxes (see distrobox.ini)
distrobox-assemble create ./distrobox.ini -R
