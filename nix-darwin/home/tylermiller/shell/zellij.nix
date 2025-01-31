{
  programs = {
    zellij = {
      enable = true;
      # Due to this issue: https://github.com/nix-community/home-manager/issues/4659#issuecomment-2470388666
      # we need to use either a real KDL file or a target/text setup
      # I am opting for an real KDL file and will use home file to link it
      # this can be seen in tylermiller/default.nix
    };
  };
}
