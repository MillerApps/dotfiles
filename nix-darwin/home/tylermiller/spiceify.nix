{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
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
      theme = spicePkgs.themes.text;
      colorScheme = "CatppuccinMocha";
    };
  };
}
