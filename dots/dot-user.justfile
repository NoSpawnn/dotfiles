_default:
    @/usr/bin/just --justfile {{ justfile() }} --list --list-heading $'Available commands:\n' --list-prefix $' - '

# Show BIOS info
[group('System')]
bios-info:
    #!/usr/bin/env bash
    echo "Manufacturer: $(sudo dmidecode -s baseboard-manufacturer)"
    echo "Product Name: $(sudo dmidecode -s baseboard-product-name)"
    echo "     Version: $(sudo dmidecode -s bios-version)"
    echo "Release Date: $(sudo dmidecode -s bios-release-date)"

# Boot into this device's BIOS/UEFI screen
[group('System')]
reboot-bios:
    #!/usr/bin/env bash
    if [ -d /sys/firmware/efi ]; then
      systemctl reboot --firmware-setup
    else
      echo "Rebooting to legacy BIOS from OS is not supported."
      exit 1
    fi

# Reboot to windows if possible
[group('System')]
reboot-windows:
    efibootmgr | grep "Windows Boot Manager" | sed -r 's/^Boot([[:digit:]]{4}).*/\1/' | xargs sudo efibootmgr --bootnext && systemctl reboot

# Create and enter a new devpod with the specified options using podman
[group('Dev')]
devpod-new LANG="" DIR="." NAME="" LANG_VERSION="latest" SHELL="zsh" IDE="zed":
    #!/usr/bin/env bash

    LANG="{{ LANG }}"
    DIR="{{ DIR }}"
    NAME="{{ NAME }}"
    LANG_VERSION="{{ LANG_VERSION }}"
    SHELL="{{ SHELL }}"
    IDE="{{ IDE }}"

    if ! command -v devpod &> /dev/null; then
        echo "The devpod CLI is not on your PATH. Add or install it to use this script."
        echo "    https://devpod.sh/docs/getting-started/install#optional-install-devpod-cli"
        exit 1
    fi

    if ! devpod provider ls | awk 'NR > 2 && /\S/ { found=1 } END { exit !found }'; then
        echo "Devpod does not have any providers. Add a docker provider with the binary set to podman to use this script."
        echo "    https://devpod.sh/docs/managing-providers/add-provider"
        exit 1
    fi

    source "$(dirname {{ justfile() }})/functions.sh"

    # https://github.com/devcontainers/images
    declare -A IMAGES=(
        [rust]="mcr.microsoft.com/devcontainers/rust"
        [go]="mcr.microsoft.com/devcontainers/go"
    )

    if [[ -z "$LANG" ]]; then
        lang="$(choose "Choose a language (image) for the container: " ${!IMAGES[@]})"
    else
        lang="$LANG"
    fi

    echo "Using language '$lang'"

    if [[ -z "$NAME" ]]; then
        name=$(basename $(realpath "$DIR"))
        NAME="${name#.}" # strip leading '.' if there is one
    else
        NAME="$NAME"
    fi

    echo "Using name $NAME"

    version="$LANG_VERSION"
    IMAGE="${IMAGES[$lang]}:$LANG_VERSION"

    unset -v name lang version # Sanity check we're using the right ones (UPPERCASE)

    cat <<EOF >"$DIR/.devcontainer.json"
    {
        "name": "$NAME",
        "image": "$IMAGE",
        "workspaceMount": "",
        "workspaceFolder": "/workspaces/\${localWorkspaceFolderBasename}",
        "runArgs": [
            "--volume=\${localWorkspaceFolder}:/workspaces/\${localWorkspaceFolderBasename}:Z"
        ]
    }
    EOF

    devpod up $DIR \
        --recreate \
        --dotfiles "https://github.com/NoSpawnn/dotfiles.git" \
        --dotfiles-script "install-devpod.sh" \
        --workspace-env "SHELL=$SHELL" \
        --ide "$IDE"

[group('Dev')]
dev-vm-new IMAGE="prompt" NAME="prompt" ENTER="ssh":
    #!/usr/bin/env bash

    IMAGE="{{ IMAGE }}"
    NAME="{{ NAME }}"
    ENTER="{{ ENTER }}"

    if ! command -v incus &> /dev/null; then
        echo "incus is not on your PATH. Add or install it to use this script."
        exit 1
    fi

    source ./functions.sh

    IMAGES=(
        "fedora/42"
        "ubuntu/22.04"
        "ubuntu/24.04"
    )

    if [ "$IMAGE" == "prompt" ]; then
      IMAGE="images:$(choose "Image for new VM: " ${IMAGES[@]})"
    fi
    if [ "$NAME" == "prompt" ]; then
      echo -en "Name for new VM: "
      read NAME
    fi

    incus_launch="incus launch --vm -c security.secureboot=false $IMAGE $NAME"
    echo "$incus_launch"
    $incus_launch

    # If we aren't entering the VM, then we're done here
    if [ "$ENTER" == "no" ]; then
        exit 0
    fi

    # Wait for the VM to launch
    # Checking the status in `incus ls` doesn't work since VMs
    # immediately say they are running, we need to wait for
    # the actual agent to start
    while ! incus exec "$NAME" /bin/true 2> /dev/null; do
        sleep 2
    done

    if [ "$ENTER" == "ssh" ]; then
        # Requires ssh2incus running and listening on port 2222
        # TODO: make agent forwarding work with bitwarden ssh agent
        # From ssh2incus log: Only NAT mode is supported for proxies on VM instances
        # https://linuxcontainers.org/incus/docs/main/reference/devices_proxy/
        ssh -p 2222 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR "$NAME+$USER@localhost"
    elif [ "$ENTER" == "shell"]; then
        incus shell $NAME
    fi

# Install flatpaks from a file
[group('Config')]
install-flatpaks LIST_FILE="" SCOPE="user":
    #!/usr/bin/env bash

    LIST_FILE="{{ LIST_FILE }}"
    SCOPE="{{ SCOPE }}"

    flatpaks=$(cat $(realpath "$LIST_FILE") | tr '\n' ' ' )

    if [[ "$SCOPE" == 'user' ]]; then
        flatpak remote-add --if-not-exists --user flathub-user https://flathub.org/repo/flathub.flatpakrepo
    fi

    flatpak install -y --"$SCOPE" $flatpaks
