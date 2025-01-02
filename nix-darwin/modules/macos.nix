{ config, pkgs, ... }:
{
  # Macos settings
  security.pam.enableSudoTouchIdAuth = true;
  system.defaults = {
    dock.persistent-apps = [
      "/Applications/Zen Browser.app"
      "/Applications/Proton Mail.app"
      "/Applications/Signal.app"
      "/Applications/Ghostty.app"
    ];
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    dock.minimize-to-application = true;
    dock.persistent-others = [
      # From what i saw on https://mynixos.com/nix-darwin/option/system.defaults.dock.persistent-others
      # this should not be Necessary ~/Downloads/ should work but nope
      "/Users/tylermiller/Downloads/"
    ];
    dock.show-recents = false;
    dock.tilesize = 50;
    trackpad.TrackpadRightClick = true;
    NSGlobalDomain."com.apple.swipescrolldirection" = false;
    finder.FXDefaultSearchScope = "SCcf";
    finder.ShowExternalHardDrivesOnDesktop = true;
    finder.ShowHardDrivesOnDesktop = true;
    finder.ShowMountedServersOnDesktop = true;
    finder.ShowPathbar = true;

    CustomUserPreferences = {
      "com.apple.finder" = {
        # Set home directory as startup window
        NewWindowTargetPath = "file:///Users/${config.users.users.tylermiller.name}/";
        NewWindowTarget = "PfHm";
      };
    };
  };
}
