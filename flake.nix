{
  description = "Home Manager configuration of n";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs =
    { nixpkgs, home-manager, nix-flatpak, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."n" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix nix-flatpak.homeManagerModules.nix-flatpak ];
      };
    };
}
