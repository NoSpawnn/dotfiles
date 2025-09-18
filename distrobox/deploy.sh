#!/usr/bin/env bash

# https://distrobox.it/usage/distrobox-assemble/

set -euxo pipefail

cd "${0%/*}"

# Create, start, then stop the core container so it's clonable

distrobox assemble create --file distrobox_dependencies_core.ini -R
distrobox stop distrobox_dependencies_core -Y

# Create actual boxes

BOXES=(
    cli_progs
    devtools_lsps
)

for box in ${BOXES[@]}; do
    distrobox assemble create "./boxes/$box.ini" -R
done
