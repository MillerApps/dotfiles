# The default.nix file serves a special purpose in Nix - it's automatically loaded when you import a directory
{
  imports = [
    ./homebrew.nix
    ./macos.nix
    ./nix.nix
    ./packages.nix
    ./system.nix
    ./users.nix
    ./zsh.nix
  ];
}
