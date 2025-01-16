# The file that will provide home manager wtf to
# do with my dotfiles
{
  pkgs,
  inputs,
  ...
}:
let
  inherit (inputs) self;
in
{
  home = {
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.11";

    file = {
      ".zshrc".source = self + "/zshrc";
      ".config/ghostty".source = self + "/ghostty";
      ".p10k.zsh".source = self + "/.p10k.zsh";
      ".config/yazi".source = self + "/yazi";
      ".config/karabiner".source = self + "/karabiner";
      ".wezterm.lua".source = self + "/.wezterm.lua";
      ".config/nvim".source = inputs.neovim-config;
    };
  };

  programs = {
    neovim = {
      enable = true;
      # Needed for 3rd/image to work
      extraLuaPackages = ps: [ ps.magick ];
      extraPackages = [ pkgs.imagemagick ];
    };

    git = {
      enable = true;
      userName = "MillerApps";
      userEmail = "tylermiller4.github@proton.me";
    };

    spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
          trashbin
          history
          fullAppDisplay
          shuffle
        ];
        enabledCustomApps = with spicePkgs.apps; [
          marketplace
        ];
        theme = spicePkgs.themes.text;
        colorScheme = "CatppuccinMocha";
      };
    gh = {
      enable = true;
      extensions = [
        pkgs.gh-markdown-preview
      ];
    };
  };
}
