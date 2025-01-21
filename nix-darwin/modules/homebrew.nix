{inputs, ...}: {
  imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];

  config = {
    # this module allows for the Homebrew module to be declaratively managed
    nix-homebrew = {
      enable = true;
      # Apple Silicon Only
      enableRosetta = true;
      # User owning the Homebrew prefix
      user = "tylermiller";

      autoMigrate = true;
    };

    # Homebrew
    homebrew = {
      enable = true;
      brews = [
        "mas"
        "tabiew"
        "otree"
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
        # Terminal
        "ghostty"
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
        # Keyboard shortcuts for every button on your screen
        "homerow"
      ];
    };
  };
}
