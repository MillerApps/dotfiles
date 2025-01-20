{pkgs, ...}: {
  programs = {
    git = {
      enable = true;
      userName = "MillerApps";
      userEmail = "tylermiller4.github@proton.me";
    };
    gh = {
      enable = true;
      extensions = with pkgs; [
        gh-markdown-preview
      ];
    };
  };
}
