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
      "com.apple.WindowManager" = {
        # Disable stage manager
        EnableStanardClickToShowDesktop = false;
        GloballyEnabled = false;
      };
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          # Disable spotlight hotkey
          "64" = {
            enabled = false;
          };
        };
      };
    };
  };
  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

    # Get the absolute path to the image, whhich is 2 directories back from this file
    IMAGE_PATH="$HOME/dotfiles/Desktop.png"
    echo "Setting desktop background to image at: $IMAGE_PATH"

    # AppleScript command to set the desktop background
    # https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/conceptual/ASLR_lexical_conventions.html#//apple_ref/doc/uid/TP40000983-CH214-SW1
    # https://www.reddit.com/r/mac/comments/ncujqi/an_applescript_to_change_all_of_your_desktops/
    osascript -e '
    tell application "System Events"
        tell current desktop
            set picture to "'"$IMAGE_PATH"'"
        end tell
    end tell'
    '';
}
