{pkgs, ...}: {
  # Enable zsh via nix-darwin
  # For more information on configuring Zsh in nix-darwin, see:
  # https://daiderd.com/nix-darwin/manual/index.html#opt-programs.zsh.interactiveShellInit
  programs.zsh = {
    enable = true;

    # Hooks that are sourced for interactive shells only
    interactiveShellInit = ''
      # zsh-autosuggestions
      if [ -f "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
        source "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
      fi

      # zsh-syntax-highlighting
      if [ -f "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
        source "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
      fi
    '';
  };
}
