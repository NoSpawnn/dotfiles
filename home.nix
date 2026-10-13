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
    neovim
    ripgrep
    tmux
    zoxide
  ];

  home.username = "n";
  home.homeDirectory = "/home/n";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
