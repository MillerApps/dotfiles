{pkgs, ...}: {
  programs = {
    neovim = {
      enable = true;
      # Needed for 3rd/image to work
      extraLuaPackages = ps: [ps.magick];
      extraPackages = [pkgs.imagemagick];
    };
  };
}
