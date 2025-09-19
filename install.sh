#!/usr/bin/env bash

set -euxo pipefail

# Install oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s

# Symlink dotfiles
stow .

# Setup distroboxes (see ./distrobox)
distrobox assemble create -R --file distrobox.ini
