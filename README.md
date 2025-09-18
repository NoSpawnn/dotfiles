# NoSpawnn/dotfiles

## Dotfiles managed using [GNU Stow](https://www.gnu.org/software/stow/)

- Best used (and built in the context of) my custom Fedora Atomic image, [eepy_OS](https://github.com/NoSpawnn/eepy_OS)

## FAQ

- What the hell is that command in your waybar config?
  - I assume you mean this:

    ```bash
    pactl list short sinks | awk '{print $2}' | awk -v current=\"$(pactl get-default-sink)\" 'BEGIN{found=0} {sinks[NR]=$1} END{for(i=1;i<=NR;i++){if(sinks[i]==current){next_sink=sinks[(i%NR)+1]; break}} print next_sink}' | xargs -r pactl set-default-sink && pactl list short sink-inputs | awk '{print $1}' | xargs -I{} pactl move-sink-input {} $(pactl get-default-sink)
    ```

  - It switches to the "next" audio device according to `pactl`, the order of devices is decided by the output for `pactl list sinks`
  - I'll explain the command:
    - First, get the names of all pulseaudio sinks, this extracts the 2nd column (whitespace separated) from the output of the `pactl` command

      ```bash
      $ pactl list short sinks | awk '{print $2}'
      alsa_output.usb-SteelSeries_Arctis_Nova_Pro_Wireless-00.analog-stereo
      alsa_output.pci-0000_0f_00.6.iec958-stereo
      bluez_output.40_72_18_F0_37_3E.1
      ```

    - Then:
      - Get the default (current) sink and assign it to `current`
      - Iterate through the sinks until we find the current one, wrapping around to the start if we need to (`i % NR + 1`)
      - Output the name of that sink

        ```bash
        awk -v current=\"$(pactl get-default-sink)\" 'BEGIN{found=0} {sinks[NR]=$1} END{for(i=1;i<=NR;i++){if(sinks[i]==current){next_sink=sinks[(i%NR)+1]; break}} print next_sink}'
        ```

    - Finally, pipe that into `pactl set-default-sink` through `xargs`, and move all active sources to that new sink

      ```bash
      xargs -r pactl set-default-sink && pactl list short sink-inputs | awk '{print $1}' | xargs -I{} pactl move-sink-input {} $(pactl get-default-sink)
      ```

## References, Inspiration, etc

- [mylinuxforwork/dotfiles: The ML4W Dotfiles for Hyprland - An advanced and full-featured configuration for the dynamic tiling window manager Hyprland. Ready to install with the Dotfiles Installer app with setup scripts for Arch, Fedora and openSuse.](https://github.com/mylinuxforwork/dotfiles)
