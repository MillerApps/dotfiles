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
    thefuck
    zsh-autosuggestions
    zsh-syntax-highlighting
    lua
    go
    serpl
    nixd
    alejandra
    ripgrep
    zsh-powerlevel10k
    oh-my-zsh
    just
    atuin
    tree-sitter
  ];
}
