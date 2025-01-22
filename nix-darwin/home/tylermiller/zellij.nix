{pkgs, ...}: {
  programs = {
    zellij = {
      enable = true;
      settings = {
        mouse_mode = true;
      };
    };
  };
}
