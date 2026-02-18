{
  inputs,
  pkgs,
  ...
}: {
  system = {
    # Set Git commit hash for darwin-version.
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;
  };


  environment.variables = {
    # set paths for powerlevel10k & oh-my-zsh
    OH_MY_ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
    POWERLEVEL10K = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
  };
}
