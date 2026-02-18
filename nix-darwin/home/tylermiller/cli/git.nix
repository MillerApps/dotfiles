{pkgs, ...}: {
  programs = {
    git = {
      enable = true;
      settings = {
        user.name = "MillerApps";
        user.email = "tylermiller4.github@proton.me";
        pull = {
          rebase = true;
        };
      };
      ignores = [
        ".DS_Store"
      ];
    };
    gh = {
      enable = true;
      extensions = with pkgs; [
        gh-markdown-preview
        gh-dash
      ];
    };
  };
}
