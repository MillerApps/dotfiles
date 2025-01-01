![nix-darwin-flake](nix-darwin-flake.png)

# Nix-Darwin, Nix-Home-Manager, & homebrew are used to manage my macOS system.
# This is will act as a guide to help me remember how to set up my system. (or anyone else who wants to use it)

> [!NOTE]
> This is a first round at intergrating nix-darwin, nix-home-manager, and homebrew. This is a work in progress and will be updated as I learn more.
> If you have any tips or know of a better way to do something, please let me know.

## Install Guide for Nix-Darwin

> [!IMPORTANT]
> The Nix package manager is required to install nix-darwin. If you have not installed Nix, please follow the instructions below.

1. Install [Nix package manager](https://nixos.org/download/#nix-install-macos) using the following command:
    ```sh
    sh <(curl -L https://nixos.org/nix/install)
   ```
2. Clone the repo to your home directory:
    ```sh
    nix run nixpkgs#git -- clone https://github.com/MillerApps/dotfiles.git ~/dotfiles
    ```
    > [!NOTE]
    > This will:
	> •	Temporarily use Git
	> •	Clone your repository
	> •	Create a dotfiles directory in your home folder
	> •	Place all repository contents in ~/dotfiles

3. Install [nix-darwin](https://github.com/LnL7/nix-darwin) for full detatils see, the installation instructions at the link. Use the flake section.
    
    > [!NOTE]
    > This installs nix-darwin using the flake feature of nix. This is the recommended way to install nix-darwin.
    > This also assumes you cloned the repo to `~/dotfiles`
    
    ```sh
     nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles/nix-darwin#macbook
     ```
4. Apply the configuration:
    ```sh
     darwin-rebuild switch --flake ~/dotfiles/nix-darwin#macbook
    ```

