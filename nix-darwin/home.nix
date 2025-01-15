# The file that will provide home manager wtf to
# do with my dotfiles
{
  config,
  neovim-config,
  pkgs,
  spicetify-nix,
  ...
}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tylermiller";
  home.homeDirectory = "/Users/tylermiller";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  home.file = {
    ".zshrc".source = ../.zshrc;
    ".config/ghostty".source = ../ghostty;
    ".p10k.zsh".source = ../.p10k.zsh;
    ".config/yazi".source = ../yazi;
    ".config/karabiner".source = ../karabiner;
    ".wezterm.lua".source = ../.wezterm.lua;
    ".config/nvim".source = neovim-config;
  };

  programs = {
    neovim = {
      enable = true;
      # Needed for 3rd/image to work
      extraLuaPackages = ps: [ps.magick];
      extraPackages = [pkgs.imagemagick];
    };
    git = {
      enable = true;
      userName = "MillerApps";
      userEmail = "tylermiller4.github@proton.me";
    };
    spicetify = let
      spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
    in {
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
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
