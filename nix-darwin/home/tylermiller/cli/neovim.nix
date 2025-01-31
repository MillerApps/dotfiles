{pkgs, ...}: {
  programs = {
    neovim = {
      enable = true;
      #3rd/image needs these
      extraLuaPackages = ps: [ps.magick];
      extraPackages = [pkgs.imagemagick];
    };
  };
}
