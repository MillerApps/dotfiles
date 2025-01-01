![nix-darwin-flake](nix-darwin-flake.png)

# Nix-Darwin, Nix-Home-Manager, & Homebrew

This repository serves as a guide for setting up and managing my macOS system using Nix-Darwin, Nix Home Manager, and Homebrew. 
It is designed for personal reference but can also be useful to others interested in a similar setup.

How it works:
- The Nix package manager is used as the primary way to handle needed clitools, lanaues, and apps.
- Nix-Darwin sets up the system based on the flake.nix and the correlating files in the nix-darwin directory.
- Nix-Home-Manager hooks into Nix-Darwin to handle the .config files and othr .files in the home directory.
- Homebrew is used to install macOS apps and fonts. This is handled by Nix-Darwin's homebrew module. Homebrew is also installed via [Nix-Homebrew](https://github.com/zhaofengli/nix-homebrew).

> [!NOTE]
> This is a first round at intergrating nix-darwin, nix-home-manager, and homebrew. This is a work in progress and will be updated as I learn more.
> If you have any tips or know of a better way to do something, please let me know.

## Table of Contents
- [Introduction](#nix-darwin-nix-home-manager--homebrew)
- [Install Guide for Nix-Darwin](#install-guide-for-nix-darwin)
  - [Install Nix Package Manager](#install-nix-package-manager)
  - [Clone Repository](#clone-repository)
  - [Install Nix-Darwin](#install-nix-darwin)
  - [Apply Configuration](#apply-configuration)

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

