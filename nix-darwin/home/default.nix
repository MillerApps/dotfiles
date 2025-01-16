{ inputs, ... }:
{
  imports = [ inputs.home-manager.darwinModules.home-manager ];

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = { inherit inputs; };

      sharedModules = [
        inputs.spicetify-nix.homeManagerModules.default

        # Let Home Manager install and manage itself.
        { programs.home-manager.enable = true; }
      ];

      users.tylermiller = ./tylermiller/default.nix;
    };
  };
}
