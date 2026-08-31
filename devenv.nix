{
  pkgs,
  ...
}:

{
  packages = with pkgs; [
    nixfmt

    shellcheck
    shfmt

    sops
    ssh-to-age

    lua-language-server
    stylua

    kdePackages.qtdeclarative
  ];

  scripts.qs.exec = "${pkgs.quickshell}/bin/quickshell -p ./dots/dot-config/quickshell/";

  enterShell = ''
    git fetch
  '';
}
