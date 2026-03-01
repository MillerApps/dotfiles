{config, ...}: {
  # Set the primary user
  # https://github.com/nix-darwin/nix-darwin/blob/b9e580c1130307c3aee715956a11824c0d8cdc5e/CHANGELOG#L1
  system.primaryUser = "tylermiller";
  # MacOS settings
  security.pam.services.sudo_local.touchIdAuth = true;
  system.defaults = {
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    dock = {
      persistent-apps = [
        "/Applications/Zen.app"
        "/Applications/Signal.app"
        "/Applications/Ghostty.app"
        "/Applications/Obsidian.app"
      ];
      minimize-to-application = true;
      show-recents = false;
      tilesize = 50;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      "com.apple.swipescrolldirection" = false;
      "com.apple.trackpad.trackpadCornerClickBehavior" = 1; # TrackpadRightClick
      NSAutomaticSpellingCorrectionEnabled = false;
    };

    trackpad.TrackpadRightClick = true;

    finder = {
      FXDefaultSearchScope = "SCcf";
      ShowExternalHardDrivesOnDesktop = true;
      ShowHardDrivesOnDesktop = true;
      ShowMountedServersOnDesktop = true;
      ShowPathbar = true;
    };

    WindowManager.EnableStandardClickToShowDesktop = false;

    CustomUserPreferences = {
      "com.apple.dock" = {
        persistent-others = [
          {
            tile-data = {
              file-data = {
                _CFURLString = "file:///Applications/";
                _CFURLStringType = 15;
              };
              displayas = 1;
              showas = 2;
            };
            tile-type = "directory-tile";
          }
          {
            tile-data = {
              file-data = {
                _CFURLString = "file:///Users/tylermiller/Downloads/";
                _CFURLStringType = 15;
              };
              arrangement = 2;
              displayas = 1;
              showas = 2;
            };
            tile-type = "directory-tile";
          }
        ];
      };
      "com.apple.finder" = {
        # Set home directory as startup window
        NewWindowTargetPath = "file:///Users/${config.users.users.tylermiller.name}/";
        NewWindowTarget = "PfHm";
      };
      # useful link for reference: https://gist.github.com/jimratliff/227088cc936065598bedfd91c360334e
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          # Disable spotlight hotkey
          "64" = {
            enabled = false;
          };
          # set notification hotkey to F19
          # 163 is the id for the notification center
          "163" = {
            enabled = true;
            value = {
              # 65535 is the prefix the keys F1-F24 or whatever it reaches
              # 80 is the keycode for F19
              # 0 means no modifiers i.e no shift, control, option, command
              parameters = [
                65535
                80
                0
              ];
              type = "standard";
            };
          };
          # Disable Mission Control
          "27" = {
            enabled = true;
            value = {
              parameters = [
                65535
                48
                1966080
              ];
              type = "standard";
            };
          };
        };
      };
    };
  };

  system.activationScripts.postActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    sudo -u tylermiller /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

    # Get the absolute path to the image
    IMAGE_PATH="Users/tylermiller/dotfiles/wallpaper/Desktop.png"
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
