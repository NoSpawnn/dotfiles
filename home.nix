{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden-desktop
    bluetui
    devenv
    eza
    fuzzel
    fzf
    git
    lazygit
    neovim
    ripgrep
    zoxide
  ];

  home.username = "n";
  home.homeDirectory = "/home/n";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
