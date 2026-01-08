{
  pkgs ? (import <nixpkgs> { }),
}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    tombi
    yaml-language-server
    bash-language-server
  ];
}
