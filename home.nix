{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    devenv
    bluetui
    neovim
    lazygit
    eza
    fzf
    ripgrep
    git
  ];

  programs.home-manager.enable = true;
  home.username = "n";
  home.homeDirectory = "/home/n";
  home.stateVersion = "26.05";
}
