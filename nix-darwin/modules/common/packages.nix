{pkgs, ...}: {
  nixpkgs = {
    # set our hostplatform
    hostPlatform = "aarch64-darwin";

    # Allow unfree packages
    config.allowUnfree = true;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    neovim
    git
    lazygit
    lazydocker
    bat
    btop
    eza
    gh
    fzf
    glow
    yazi
    zoxide
    zsh-autosuggestions
    zsh-syntax-highlighting
    lua
    go
    serpl
    # Apparently this is not compatible with lix but worked until today
    # https://github.com/NixOS/nixpkgs/issues/358329
    # nixd
    nil
    alejandra
    ripgrep
    zsh-powerlevel10k
    oh-my-zsh
    just
    atuin
    tree-sitter
    vhs
    charm-freeze
  ];
}
