{pkgs, ...}: {
  programs = {
    git = {
      enable = true;
      userName = "MillerApps";
      userEmail = "tylermiller4.github@proton.me";
      ignores = [
        ".DS_Store"
      ];
      extraConfig = {
        pull = {
          rebase = true;
        };
      };
    };
    gh = {
      enable = true;
      extensions = with pkgs; [
        gh-markdown-preview
      ];
    };
  };
}
