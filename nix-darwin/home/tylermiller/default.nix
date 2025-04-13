# The file that will provide home manager wtf to
# do with my dotfiles
{
  inputs,
  lib,
  ...
}: let
  # `self` points to the directory containing flake.nix (nix-darwin/)
  # When using home-manager as a nix-darwin module, we inherit it from inputs
  inherit (inputs) self;
in {
  # Import the individual programs (git, spicetify, neovim) which are in their own
  # nix files for organization and modularity. If there is a better way to do this
  # open a pull request or issue on the github repo with an explanation.
  # Thanks! Still learning nix and nixos.
  imports = [
    ./spiceify.nix
    ./cli/default.nix
    ./shell/default.nix
  ];

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
      # Since flake.nix is in the nix-darwin/ directory,
      # we need to go up one level with "../" to reach the dotfiles root.
      #
      # Path resolution:
      # self         -> /nix/store/xxx-source/nix-darwin
      # self + "/.." -> /nix/store/xxx-source
      #
      # This ensures we can reference files relative to the dotfiles root
      # regardless of where the home-manager configuration itself lives
      # This took me a while to figure out. As i tried it once before
      # and it didn't work. But now it does. I think it was because
      # of a stale state in the nix store.
      # Possible fix is to run `nix-collect-garbage -d` to clear
      # nix cache
      ".zshrc".source = self + "/../.zshrc";
      ".config/ghostty".source = self + "/../ghostty";
      ".p10k.zsh".source = self + "/../.p10k.zsh";
      ".config/yazi".source = self + "/../yazi";
      ".config/karabiner".source = self + "/../karabiner";
      ".wezterm.lua".source = self + "/../.wezterm.lua";
      # ".config/nvim".source = self + "/../nvim";
      ".config/zellij".source = self + "/../zellij";
    };
    activation = {
      # This ensures our script runs at the right time:
      # - 'dag' helps control the order of operations
      # - 'entryAfter' means "run after the specified phase"
      # - 'writeBoundary' is the phase after Home Manager writes all files
      # https://nix-community.github.io/home-manager/options.html#opt-home.activation
      # DAG (Directed Acyclic Graph) is like a one-way recipe:
      # - Directed: Tasks flow one direction (can't frost before baking)
      # - Acyclic: No loops allowed (can't bake -> frost -> bake again)
      #
      # Here it's simple:
      # 1. Write all files (writeBoundary)
      #        ↓
      # 2. Create symlinks (our script)
      # https://www.getdbt.com/blog/guide-to-dags
      #
      # Custom linking method for neovim configuration:
      # - Preserves lazy.nvim plugin manager functionality
      # - Avoids direct Nix store linking which would make the config immutable ie. '".config/nvim".source = self + "/../nvim";'
      # - Allows for dynamic updates to neovim configuration

      linkNvimConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
        echo "Linking nvim config"
        run mkdir -p ~/.config/nvim
        run ln -sf ~/dotfiles/nvim/* ~/.config/nvim/

        echo "linking aerospace config"
        run mkdir -p ~/.config/aerospace
        run ln -sf ~/dotfiles/aerospace/* ~/.config/aerospace/
      '';
    };
  };
}
