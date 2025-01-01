{
  description = "Tyler's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-homebrew }:
    let
      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = [
          pkgs.ghostty
          pkgs.neovim
          pkgs.git
          pkgs.lazygit
          pkgs.bat
          pkgs.btop
          pkgs.eza
          pkgs.gh
          pkgs.fzf
          pkgs.yazi
          pkgs.zoxide
          pkgs.thefuck
          pkgs.zsh-autosuggestions
          pkgs.zsh-syntax-highlighting
          pkgs.lua
          pkgs.go
        ];

        # Homebrew
        homebrew = {
          enable = true;
          taps = [
            { 
              name = "zen-browser/browser"; 
              clone_target = "https://github.com/zen-browser/desktop.git"; 
            }
          ];
          brews = [
            "mas"
          ];
          masApps = {
            "ExcalidrawZ" = 6636493997;
            "Infuse" = 1136220934;
            "Amphetamine" = 937984704;
            "Final Cut Pro" = 424389933;
            "Keka" = 470158793;
          };
          # Must have apps
          casks = [
            # AirPods companion app
            "airbuddy"
            # Menu bar tool to limit maximum charging percentage
            "aldente"
            # Enable Windows-like alt-tab
            "alt-tab"
            # Application uninstaller
            "appcleaner"
            # 3D model slicing software for 3D printers, maintained by Bambu Lab
            "bambu-studio"
            # Utility improving 3rd party mouse performance and functionalities
            "bettermouse"
            # OpenAI's official ChatGPT desktop app 
            "chatgpt"
            # Screen capturing tool
            "cleanshot"
            # Server and cloud storage browser
            "cyberduck"
            # Productivity app
            "dropzone"
            # Desktop client for Ente Photos
            "ente"
            # Desktop client for Ente Auth
            "ente-auth"
            "font-jetbrains-mono-nerd-font"
            "font-meslo-lg-nerd-font"
            "font-monaspace-nerd-font"
            "font-roboto-mono-nerd-font"
            # Automated organisation
            "hazel"
            # Free and open-source media player
            "iina"
            # Menu bar manager
            "jordanbaird-ice"
            # Keyboard customiser
            "karabiner-elements"
            # Tool to control external monitor brightness & volume
            "monitorcontrol"
            # VPN client
            "mullvadvpn"
            # Knowledge base that works on top of a local folder of plain text Markdown files
            "obsidian"
            # Client for Proton Drive
            "proton-drive"
            # Client for Proton Mail and Proton Calendar
            "proton-mail"
            # Desktop client for Proton Pass
            "proton-pass"
            # VPN client focusing on security
            "protonvpn"
            # Control your tools with a few keystrokes
            "raycast"
            # Instant messaging application focusing on security
            "signal"
            # Music streaming service
            "spotify"
            # System monitor for the menu bar
            "stats"
            # Mesh VPN based on WireGuard
            "tailscale"
            # Web browser focusing on security
            "tor-browser"
            # Multiplayer code editor
            "zed"
            # Gecko based web browser
            "zen-browser"
          ];
        };

        users.users.tylermiller.home = "/Users/tylermiller";
        
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

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Enable alternative shell support in nix-darwin.
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";

      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#macbook
      darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          # home-manager as a module
          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tylermiller = import ./home.nix;       
          }
          nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            # Apple Silicon Only
            enableRosetta = true;
            # User owning the Homebrew prefix
            user = "tylermiller";

            autoMigrate = true;
            };
          }
        ];
      };
    };
}

