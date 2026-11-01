{ config, pkgs, ... }:

{
  targets.genericLinux.enable = true;
  targets.genericLinux.gpu.enable = true;

  home.packages = with pkgs; [
    bitwarden-desktop
    bluetui
    devenv
    eza
    fastfetch
    fuzzel
    fzf
    git
    lazygit
    lua-language-server
    neovim
    ripgrep
    tealdeer
    tmux
    quickemu
    zoxide
    xwayland-satellite
  ];

  services.flatpak = {
      enable = true;

      packages = [
        #"com.valvesoftware.Steam" # need to figure out deps for this
        "org.signal.Signal"
        "dev.vencord.Vesktop"
        "com.orcaslicer.OrcaSlicer"
      ];

      overrides.settings = {
          # https://github.com/OrcaSlicer/OrcaSlicer/issues/15920 - should be fixed in prod soon
          "com.orcaslicer.OrcaSlicer".Context.sockets = [ "!wayland" "x11" ];
      };
  };

  home.username = "n";
  home.homeDirectory = "/home/n";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
