{ config, pkgs, ... }:

{
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
  ];

  services.flatpak = {
      enable = true;
      packages = [
        #"com.valvesoftware.Steam" # need to figure out deps for this
        "dev.vencord.Vesktop"
      ];
  };

  home.username = "n";
  home.homeDirectory = "/home/n";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
