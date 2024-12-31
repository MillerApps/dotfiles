{
  description = "Tyler's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
            pkgs.neovim
            pkgs.git
            pkgs.lazygit
            pkgs.bat
            pkgs.btop
            pkgs.eza
            pkgs.gh
            pkgs.fzf
            pkgs.yazi
            pkgs.zoxide
            pkgs.thefuck
            pkgs.zsh-autosuggestions
            pkgs.zsh-syntax-highlighting
            pkgs.lua
            pkgs.go
        ];
        
      # Enable zsh via nix-darwin
      # For more information on configuring Zsh in nix-darwin, see:
      # https://daiderd.com/nix-darwin/manual/index.html#opt-programs.zsh.interactiveShellInit
      programs.zsh = {
        enable = true;

        # Hooks that are sourced for interactive shells only
        interactiveShellInit = ''
          # zsh-autosuggestions
          if [ -f "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
            source "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
          fi

          # zsh-syntax-highlighting
          if [ -f "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
            source "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
          fi
        '';
      };

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
      modules = [ configuration ];
    };
  };
}
