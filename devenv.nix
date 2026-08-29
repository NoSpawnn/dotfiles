{
  pkgs,
  ...
}:

{
  packages = with pkgs; [
    nixfmt

    shellcheck
    stow
    shfmt

    sops
    ssh-to-age

    lua-language-server
    stylua
  ];

  enterShell = ''
    git fetch
  '';
}
