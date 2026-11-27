{pkgs, ...}: {
  programs = {
    neovim = {
      enable = true;
      withPython3 = true;
      withRuby = true;
      #3rd/image needs these
      extraLuaPackages = ps: [ps.magick];
      extraPackages = [pkgs.imagemagick];
    };
  };
}
