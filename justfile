# Justfile for nix-darwin system management

# Switch to the current flake configuration
switch:
    darwin-rebuild switch --flake ~/dotfiles/nix-darwin#macbook
    
# Bootstrap nix-darwin
# Install Xcode Command Line Tools
bootstrap:
	xcode-select --install
	nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles/nix-darwin#macbook

# Clean unused store entries
clean:
    nix-collect-garbage

# Clean all unused store entries
clean-all:
    nix-collect-garbage -d

# Update flake inputs
update:
    nix flake update ~/dotfiles/nix-darwin

# Verify configuration
check:
    darwin-rebuild check --flake ~/dotfiles/nix-darwin#macbook

# Rollback to previous generation
rollback:
    darwin-rebuild rollback --flake ~/dotfiles/nix-darwin#macbook

# Show system generations
generations:
    darwin-rebuild --list-generations

# Build configuration without switching
build:
    darwin-rebuild build --flake ~/dotfiles/nix-darwin#macbook
