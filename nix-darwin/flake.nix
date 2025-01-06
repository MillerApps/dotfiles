{
  description = "Tyler's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    neovim-config = {
      url = "github:millerapps/yoink.nvim"; # This pulls my neovim config
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-homebrew, neovim-config, ... }:
    let
      modules = import ./modules;
      configuration = { pkgs, config, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages =  with pkgs; [
          neovim
          git
          lazygit
          bat
          btop
          eza
          gh
          fzf
          yazi
          zoxide
          thefuck
          zsh-autosuggestions
          zsh-syntax-highlighting
          lua
          go
          serpl
          nixd
        ];

        users.users.tylermiller.home = "/Users/tylermiller";

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Enable alternative shell support in nix-darwin.
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";

      };
    in
      {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#macbook
      darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          modules.homebrew
          modules.macos
          modules.zsh
          # home-manager as a module
          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tylermiller = import ./home.nix;
            home-manager.extraSpecialArgs = { inherit neovim-config; };
          }
          nix-homebrew.darwinModules.nix-homebrew {
            nix-homebrew = {
              enable = true;
              # Apple Silicon Only
              enableRosetta = true;
              # User owning the Homebrew prefix
              user = "tylermiller";

              autoMigrate = true;
            };
          }
        ];
      };
    };
}

