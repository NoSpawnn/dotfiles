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

    kdePackages.qtdeclarative
  ];

  scripts.qs.exec = "${pkgs.quickshell}/bin/quickshell -p ./dots/dot-config/quickshell";
  scripts.stylua.exec = "${pkgs.stylua}/bin/stylua  --config-path ${./.stylua.toml} $@";

  enterShell = ''
    git fetch
  '';
}
