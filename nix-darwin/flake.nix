{
  description = "Tyler's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # lix = {
    #   url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
    #   flake = false;
    # };
    #
    # lix-module = {
    #   url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.lix.follows = "lix";
    # };
    #
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{self, nixpkgs, ...}: let
    systems = [
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    forAllSystems = f:
      builtins.listToAttrs (map (system: {
          name = system;
          value = f system;
        }) systems);
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#macbook
    darwinConfigurations."macbook" = inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./modules/default.nix
        ./home/default.nix
        # inputs.lix-module.nixosModules.default
        ({pkgs, ...}: {
          nix.package = pkgs.lixPackageSets.stable.lix;
        })
      ];
    };

    packages = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      install-homebrew = pkgs.callPackage ./pkgs/homebrew-bootstrap.nix {};
      default = self.packages.${system}.install-homebrew;
    });

    apps = forAllSystems (system: {
      install-homebrew = {
        type = "app";
        program = "${self.packages.${system}.install-homebrew}/bin/install-homebrew";
      };
      default = self.apps.${system}.install-homebrew;
    });
  };
}
