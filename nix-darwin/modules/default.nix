# The default.nix file serves a special purpose in Nix - it's automatically loaded when you import a directory
{
  imports = [
    ./darwin/homebrew.nix
    ./darwin/macos.nix
    ./common/nix.nix
    ./common/packages.nix
    ./common/system.nix
    ./common/users.nix
    ./common/zsh.nix
  ];
}
