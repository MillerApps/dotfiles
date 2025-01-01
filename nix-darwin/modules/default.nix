# The default.nix file serves a special purpose in Nix - it's automatically loaded when you import a directory
{
  homebrew = import ./homebrew.nix;
  macos = import ./macos.nix;
  zsh = import ./zsh.nix;
}
