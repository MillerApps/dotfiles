{ config, pkgs, ... }:
{
  # Macos settings
  security.pam.enableSudoTouchIdAuth = true;
  system.defaults = {
    dock.persistent-apps = [
      "/Applications/Zen Browser.app"
      "/Applications/Proton Mail.app"
      "/Applications/Signal.app"
      /* "/nix/store/rvlqdas14krhh86z1n9safky4rkfyksa-system-applications/Applications/Ghostty.app" */
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

  system.activationScripts.postActivation.text = ''
          # Get the Nix store path of your app
          # we need to do it this way as to avoid
          # an nasty symlink icon overlay
          app_path="${pkgs.ghostty}/Applications/Ghostty.app"

          # Add to dock using defaults
          # this be added to the end of the dock
          # even after open apps which are not persistent
          defaults write com.apple.dock persistent-apps -array-add "<dict>
          <key>tile-data</key>
          <dict>
          <key>file-data</key>
          <dict>
          <key>_CFURLString</key>
          <string>$app_path</string>
          <key>_CFURLStringType</key>
          <integer>0</integer>
          </dict>
          </dict>
          </dict>"

          # Restart Dock to apply changes
          killall Dock
          '';
}
